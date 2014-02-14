module GherkinRuby
  class ColumnWidthVisitor
    attr_reader :widths

    def initialize
      @widths = []
    end

    def visit(ast)
      ast.accept(self)
    end

    def visit_TableRow(row)
      i = -1
      row.each do |cell|
        i += 1
        if @widths[i].nil? || cell.length > @widths[i]
          @widths[i] = cell.length
        end
      end
    end

    def visit_ExamplesTable(rows)
      rows.each { |row| row.accept(self) }
    end

    def visit_ScenarioOutline(outline)
      outline.examples.each { |row| row.accept(self) }
    end

    def visit_Step(step)
      step.table.each { |row| row.accept(self) }
    end
  end
end