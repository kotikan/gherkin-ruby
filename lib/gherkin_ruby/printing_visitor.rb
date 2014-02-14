require_relative 'column_width_visitor'

module GherkinRuby
  class PrintingVisitor

    def initialize(path='.')
      @path = path.split('/')
    end

    def visit(ast)
      ast.accept(self)
    end

    def visit_FeatureGroup(group)
      @path.push(group.name)
      group.each { |item| item.accept(self) }
      @path.pop
    end

    def visit_Feature(feature)
      @file = create_feature_file(@path, feature)

      @file.puts "#{get_tags_string(feature.tags)}" if feature.tags.any?

      @file.puts "Feature: #{feature.name}"
      feature.description.each { |line| @file.puts "  #{line}" } unless feature.description.nil?
      feature.background.accept(self)
      feature.each { |scenario| scenario.accept(self) }
    end

    def visit_Scenario(scenario)
      @file.puts "\n"

      if scenario.tags.any?
        @file.puts "  #{get_tags_string(scenario.tags)}"
      end

      @file.puts "  Scenario: #{scenario.name}\n"
      scenario.each { |step| step.accept(self) }
    end

    def visit_ScenarioOutline(scenario)
      @file.puts "\n"

      if scenario.tags.any?
        @file.puts "  #{get_tags_string(scenario.tags)}"
      end

      @file.puts "  Scenario Outline: #{scenario.name}\n"
      scenario.each { |step| step.accept(self) }

      unless scenario.examples.nil?
        @widths_visitor = ColumnWidthVisitor.new
        scenario.examples.accept(@widths_visitor)
        scenario.examples.accept(self)
      end
    end

    def visit_ExamplesTable(examples_table)
      @file.puts "    Examples:"

      examples_table.each { |row| row.accept(self) }
    end

    def visit_TableRow(row)
      widths = @widths_visitor.widths
      cells = []

      row.each_with_index do |cell, i|
        cells.push(cell + ' ' * (widths[i] - cell.length))
      end

      @file.puts "      | #{cells.join(' | ')} |"
    end

    def visit_Background(background)
      @file.puts "\n  Background:"
      background.each { |step| step.accept(self) }
    end

    def visit_Step(step)
      @file.puts "    #{step.keyword} #{step.name}"

      unless step.doc_string.nil?
        @file.puts '      """'
        step.doc_string.each { |line| @file.puts("      #{line}") }
        @file.puts '      """'
      end

      unless step.table.nil?
        @widths_visitor = ColumnWidthVisitor.new
        step.table.each { |row| row.accept(@widths_visitor) }
        step.table.each { |row| row.accept(self) }
      end
    end

    private

    def create_feature_file(path, feature)
      File.new("#{path.join('/')}/#{get_feature_file_name(feature)}.feature")
    end

    def get_feature_file_name(feature)
      feature.name.downcase.gsub(/\s/, '_')
    end

    def get_tags_string(tags)
      tags.map { |tag| "@#{tag.name.strip}" }.join(' ')
    end

  end
end