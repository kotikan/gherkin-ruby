require_relative '../../test_helper'

module GherkinRuby
  describe ScenarioParser do
    before do
      @lexer = ScenarioParser.new
    end

    it 'ignores commments' do
      @lexer.tokenize("# this is a comment").must_equal []
    end

    it 'parses newlines' do
      @lexer.tokenize("\n\n").must_equal [[:NEWLINE, "\n"], [:NEWLINE, "\n"]]
    end

    it 'parses text and strips it' do
      @lexer.tokenize("  Arbitrary text ").must_equal [[:TEXT, "Arbitrary text"]]
    end

    it 'parses tags' do
      @lexer.tokenize("@javascript @wip").must_equal [
        [:TAG, "javascript"],
        [:TAG, "wip"],
      ]
    end

    describe 'Keywords' do
      %w(Scenario:).each do |keyword|
        it "parses #{keyword}:" do
          name = keyword[0..-2]
          @lexer.tokenize(keyword).must_equal [[name.upcase.to_sym, name]]
        end
      end
    end

    describe 'Step keywords' do
      %w(Given When Then And But).each do |keyword|
        it "parses #{keyword}" do
          @lexer.tokenize(keyword).must_equal [[keyword.upcase.to_sym, keyword]]
        end
      end
    end

    describe 'Tables' do
      it 'parses tables' do
        @lexer.tokenize("| r1 c1 | r1 c2 |\n| r2 c1 | r2 c2 |").must_equal [[:TABLE_ROW_START, '|'], [:TABLE_CELL, 'r1 c1'], [:TABLE_CELL, 'r1 c2'], [:NEWLINE, "\n"], [:TABLE_ROW_START, '|'], [:TABLE_CELL, 'r2 c1'], [:TABLE_CELL, 'r2 c2']]
      end
    end

    describe 'Doc strings' do
      it 'parses doc strings' do
        @lexer.tokenize("#{'"""'}A doc-string\nSpanning multiple lines#{'"""'}").must_equal [[:DOC_STRING_START, '"""'], [:DOC_STRING_LINE, 'A doc-string'], [:NEWLINE, "\n"], [:DOC_STRING_LINE, 'Spanning multiple lines'], [:DOC_STRING_END, '"""']]
      end
    end

    describe 'Complete scenario' do
      it 'parses complete scenarios' do
        tokens = @lexer.tokenize('
@tag-1 @tag-2
Scenario: a complete scenario
  Given one step
  And another step
    """
    with a doc string
    containing two lines
    """
  But this step
    | has       | a     |
    | multiline | table |
  When this is parsed
  Then it should be correct
')

        tokens.must_equal [[:NEWLINE, "\n"],
                           [:TAG, "tag-1"], [:TAG, "tag-2"], [:NEWLINE, "\n"],
                           [:SCENARIO, "Scenario"], [:TEXT, "a complete scenario"], [:NEWLINE, "\n"],
                           [:GIVEN, "Given"], [:TEXT, "one step"], [:NEWLINE, "\n"],
                           [:AND, "And"], [:TEXT, "another step"], [:NEWLINE, "\n"],
                           [:DOC_STRING_START, "\"\"\""], [:NEWLINE, "\n"],
                           [:DOC_STRING_LINE, "with a doc string"], [:NEWLINE, "\n"],
                           [:DOC_STRING_LINE, "containing two lines"], [:NEWLINE, "\n"],
                           [:DOC_STRING_END, "\"\"\""], [:NEWLINE, "\n"],
                           [:BUT, "But"], [:TEXT, "this step"], [:NEWLINE, "\n"],
                           [:TABLE_ROW_START, "|"], [:TABLE_CELL, "has"], [:TABLE_CELL, "a"], [:NEWLINE, "\n"],
                           [:TABLE_ROW_START, "|"], [:TABLE_CELL, "multiline"], [:TABLE_CELL, "table"], [:NEWLINE, "\n"],
                           [:WHEN, "When"], [:TEXT, "this is parsed"], [:NEWLINE, "\n"],
                           [:THEN, "Then"], [:TEXT, "it should be correct"], [:NEWLINE, "\n"]
                          ]
      end
    end

  end
end
