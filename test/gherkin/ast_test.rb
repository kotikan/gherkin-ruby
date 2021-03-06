require_relative '../test_helper'
require 'ostruct'

class MyVisitor
  def visit_MyNode(my_node)
    my_node.elements
  end
end

class MyNode < GherkinRuby::AST::Node
  attr_reader :elements
  def initialize(name, elements)
    @name     = name
    @elements = elements
  end
end

module GherkinRuby
  module AST
    describe Node do
      it 'is visitable' do
        my_node = MyNode.new('My Node', ['foo', 'bar', 'baz'])
        visitor = MyVisitor.new

        my_node.accept(visitor).must_equal ['foo', 'bar', 'baz']
      end
    end

    [FeatureGroup, Feature, Scenario, Tag].each do |node|
      describe node do
        it 'is a Node' do
          node.ancestors.must_include Node
        end

        it 'has a line' do
          instance = node.new('Name')
          instance.name.must_equal 'Name'
          instance.must_respond_to :line
        end
      end
    end

    describe FeatureGroup do
      it 'is Enumerable' do
        elements = ['+foo', '+bar']
        instance = FeatureGroup.new('features', elements)
        instance.each.to_a.must_equal ['+foo', '+bar']
      end
    end

    describe Feature do
      it 'is Enumerable' do
        tags = ['-foo', '-bar']
        background = ['foo', 'bar']
        elements = ['+foo', '+bar']

        instance = Feature.new('My feature', elements, tags, background )
        instance.tags.each.to_a.must_equal ['-foo', '-bar']
        instance.background.each.to_a.must_equal ['foo', 'bar']
        instance.each.to_a.must_equal ['+foo', '+bar']
      end
    end

    describe Scenario do
      before do
        @steps = [
          OpenStruct.new(line: 4),
          OpenStruct.new(line: 5),
        ]
      end

      it 'is Enumerable' do
        instance = Scenario.new('Name', @steps)
        instance.each.to_a.must_equal @steps
      end

      it 'has tags' do
        tags  = ['javascript', 'wip']

        instance = Scenario.new('Name', @steps, tags)
        instance.tags.must_equal tags
      end
    end

    describe ScenarioOutline do
      before do
        @steps = [
            OpenStruct.new(line: 4),
            OpenStruct.new(line: 5),
        ]
        @examples = [
            OpenStruct.new(line: 9),
            OpenStruct.new(line: 10),
        ]
      end

      it 'is Enumerable' do
        instance = ScenarioOutline.new('Name', @steps, @examples)
        instance.each.to_a.must_equal @steps
      end

      it 'has an examples table' do
        instance = ScenarioOutline.new('Name', @steps, @examples)
        instance.examples.each.to_a.must_equal @examples
      end

      it 'has tags' do
        tags  = ['javascript', 'wip']

        instance = ScenarioOutline.new('Name', @steps, @examples, tags)
        instance.tags.must_equal tags
      end
    end

    describe Background do
      before do
        @steps = [
          OpenStruct.new(line: 4),
          OpenStruct.new(line: 5),
        ]
      end

      it 'is a Node' do
        Background.ancestors.must_include Node
      end

      it 'is Enumerable' do
        instance = Background.new(@steps)
        instance.each.to_a.must_equal @steps
      end

      describe 'when there are background steps' do
        it 'records line' do
          instance = Background.new(@steps)
          instance.pos('file', 3)
          instance.line.must_equal 3
        end
      end

      describe 'otherwise' do
        it 'does not' do
          instance = Background.new([])
          instance.line.must_equal nil
        end
      end
    end

    describe Step do
      it 'is a Node' do
        Step.ancestors.must_include Node
      end

      it 'has a line' do
        instance = Step.new('Name', 'Given')
        instance.pos('file', 2)
        instance.name.must_equal 'Name'
        instance.keyword.must_equal 'Given'
        instance.line.must_equal 2
      end

      it 'has a doc string' do
        instance = Step.new('Name', 'Given')
        instance.doc_string = "Multiline\ndoc string"
        instance.doc_string.must_equal "Multiline\ndoc string"
      end

      it 'has a table' do
        instance = Step.new('Name', 'Given')
        instance.table = [['r1 c1', 'r1 c2'], ['r2 c1', 'r2 c2']]
        instance.table[0][0].must_equal 'r1 c1'
        instance.table[0][1].must_equal 'r1 c2'
        instance.table[1][0].must_equal 'r2 c1'
        instance.table[1][1].must_equal 'r2 c2'
      end
    end

    describe ExamplesTable do
      before do
        @rows = [
            OpenStruct.new(line: 4),
            OpenStruct.new(line: 5),
        ]
      end

      it 'is a Node' do
        ExamplesTable.ancestors.must_include Node
      end

      it 'is enumerable' do
        instance = ExamplesTable.new(@rows)
        instance.each.to_a.must_equal @rows
      end
    end

    describe TableRow do
      before do
        @cells = [
            OpenStruct.new(line: 4),
            OpenStruct.new(line: 5),
        ]
      end

      it 'is a Node' do
        TableRow.ancestors.must_include Node
      end

      it 'is enumerable' do
        instance = TableRow.new(@cells)
        instance.each.to_a.must_equal @cells
      end
    end
  end
end
