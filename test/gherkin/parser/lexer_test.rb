require_relative '../../test_helper'

module GherkinRuby
  describe Parser do
    before do
      @lexer = Parser.new
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
      %w(Feature: Background: Scenario: Examples:).each do |keyword|
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

    it 'parses tables' do
      @lexer.tokenize("| r1 c1 | r1 c2 |\n| r2 c1 | r2 c2 |").must_equal [[:TABLE_ROW_START, '|'], [:TABLE_CELL, 'r1 c1'], [:TABLE_CELL, 'r1 c2'], [:NEWLINE, "\n"], [:TABLE_ROW_START, '|'], [:TABLE_CELL, 'r2 c1'], [:TABLE_CELL, 'r2 c2']]
    end

    it 'parses doc strings' do
      @lexer.tokenize("#{'"""'}A doc-string\nSpanning multiple lines#{'"""'}").must_equal [[:DOC_STRING_START, '"""'], [:DOC_STRING_LINE, 'A doc-string'], [:NEWLINE, "\n"], [:DOC_STRING_LINE, 'Spanning multiple lines'], [:DOC_STRING_END, '"""']]
    end

    it 'parses scenario outlines' do
      @lexer.tokenize('Scenario Outline:').must_equal [[:OUTLINE, 'Scenario Outline']]
    end

  end
end
