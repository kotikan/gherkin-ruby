require_relative '../test_helper'
include Helpers

module GherkinRuby
  describe ColumnWidthVisitor do
    before do
      @rows = [
          AST::TableRow.new(['1', '12', '123']),
          AST::TableRow.new(['123', '1234', '12']),
          AST::TableRow.new(['12345', '123', '1'])
      ]
      @examples_table = AST::ExamplesTable.new(@rows)
    end

    it 'should correctly determine column widths' do
      visitor = ColumnWidthVisitor.new

      @examples_table.each { |row| row.accept(visitor) }

      visitor.widths.must_equal([5, 4, 3])
    end

    it 'should determine column widths when supplied an examples table' do
      visitor = ColumnWidthVisitor.new

      visitor.visit(@examples_table)

      visitor.widths.must_equal([5, 4, 3])
    end

    it 'should determine column widths when supplied a scenario outline' do
      scenario_outline = AST::ScenarioOutline.new('Name', [], @examples_table)
      visitor = ColumnWidthVisitor.new

      visitor.visit(scenario_outline)

      visitor.widths.must_equal([5, 4, 3])
    end

    it 'should determine column widths when supplied a step with a table' do
      step = AST::Step.new('Name', 'Given')
      step.table = @rows
      visitor = ColumnWidthVisitor.new

      visitor.visit(step)

      visitor.widths.must_equal([5, 4, 3])
    end
  end

end