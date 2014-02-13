require '../../test_helper'

module GherkinRuby
  describe ScenarioParser do
    def parse(input)
      parser = ScenarioParser.new
      parser.parse(input)
    end

    describe 'Scenario name' do
      it 'parses scenario with tags' do
        scenario = parse('
@wip @with-dash
Scenario: Do something
  Given foo
')
        scenario.name.must_equal "Do something"
        scenario.tags.first.name.must_equal "wip"
        scenario.tags.last.name.must_equal "with-dash"
      end

      it 'parses scenario with tags event without newline at start' do
        scenario = parse('@wip
Scenario: Do something
  Given foo
')
        scenario.name.must_equal "Do something"
        scenario.tags.first.name.must_equal "wip"
      end

      it 'parses scenario with tags event without newline at end' do
        scenario = parse('
@wip
Scenario: Do something
  Given foo
  Then something else')

        scenario.name.must_equal "Do something"
        scenario.steps.first.name.must_equal "foo"
        scenario.steps.last.name.must_equal "something else"
      end

      it 'parses scenario containing a doc string' do
        scenario = parse("
Scenario: Foo bar baz
  Given blah foo bar
  #{'"""'}
  with a doc string
  how exciting!
  #{'"""'}
")
        doc_string = scenario.steps[0].doc_string
        doc_string[0].must_equal('with a doc string')
        doc_string[1].must_equal('how exciting!')
      end

      it 'parses scenario containing a table' do
        scenario = parse('
Scenario: Foo bar baz
  Given blah foo bar
  Then something else
    | r1 c1 | r2 c1 |
    | r1 c2 | r2 c2 |
')
        table = scenario.steps.last.table
        table.size.must_equal 2
        table[0].size.must_equal 2
        table[1].size.must_equal 2
        table[0][0].must_equal 'r1 c1'
        table[0][1].must_equal 'r2 c1'
        table[1][0].must_equal 'r1 c2'
        table[1][1].must_equal 'r2 c2'
      end
    end
  end
end
