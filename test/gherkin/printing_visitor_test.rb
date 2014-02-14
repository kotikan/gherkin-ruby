require 'stringio'
require_relative '../test_helper'
include Helpers

module GherkinRuby
  class PrintingVisitor
    attr_reader :mock_files, :mock_file_locations

    def initialize(path='.')
      @path = path.split('/')
      @mock_files = []
      @mock_file_locations = []
    end

    def mock_file
      @mock_files.last
    end

    def mock_file_location
      @mock_file_locations.last
    end

    private

    def create_feature_file(path, feature)
      @mock_file_locations.push "#{path.join('/')}/#{get_feature_file_name(feature)}.feature"
      @mock_files.push StringIO.new
      @mock_files.last
    end
  end

  describe PrintingVisitor do
    it 'should print a feature file' do
      feature = create_feature
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      ast = parser.parse(feature)

      printer.visit(ast)

      printer.mock_file.string.must_equal feature
      printer.mock_file_location.must_equal './serve_coffee.feature'
    end

    it 'should allow the base directory to be selected' do
      feature = create_feature
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new('/tmp/')
      ast = parser.parse(feature)

      printer.visit(ast)

      printer.mock_file.string.must_equal feature
      printer.mock_file_location.must_equal '/tmp/serve_coffee.feature'
    end

    it 'should print a feature file containing a scenario outline' do
      feature = create_feature_with_scenario_outline
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      ast = parser.parse(feature)

      printer.visit(ast)

      printer.mock_file.string.must_equal feature
      printer.mock_file_location.must_equal './serve_many_coffees.feature'
    end

    it 'should print a feature file containing a step with a doc string' do
      feature = create_feature_with_doc_string
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      ast = parser.parse(feature)

      printer.visit(ast)

      printer.mock_file.string.must_equal feature
      printer.mock_file_location.must_equal './serve_coffee.feature'
    end

    it 'should print a feature file containing a step with a data table' do
      feature = create_feature_with_table
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      ast = parser.parse(feature)

      printer.visit(ast)

      printer.mock_file.string.must_equal feature
      printer.mock_file_location.must_equal './serve_coffee.feature'
    end

    it 'should print a group of feature files' do
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      features = [
          create_feature,
          create_feature_with_scenario_outline
      ]
      ast = GherkinRuby::AST::FeatureGroup.new('group_name', [
          parser.parse(features[0]),
          parser.parse(features[1])
      ])

      printer.visit(ast)

      printer.mock_files.first.string.must_equal features.first
      printer.mock_file_locations.first.must_equal './group_name/serve_coffee.feature'
      printer.mock_files.last.string.must_equal features.last
      printer.mock_file_locations.last.must_equal './group_name/serve_many_coffees.feature'
    end

    it 'should print a nested group of feature files' do
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::PrintingVisitor.new
      features = [
          create_feature,
          create_feature_with_scenario_outline
      ]
      ast = GherkinRuby::AST::FeatureGroup.new('first_group', [
          GherkinRuby::AST::FeatureGroup.new('first_inner', [
              parser.parse(features[0])
          ]), GherkinRuby::AST::FeatureGroup.new('second_inner', [
              parser.parse(features[1])
          ])
      ])

      printer.visit(ast)

      printer.mock_files.first.string.must_equal features.first
      printer.mock_file_locations.first.must_equal './first_group/first_inner/serve_coffee.feature'
      printer.mock_files.last.string.must_equal features.last
      printer.mock_file_locations.last.must_equal './first_group/second_inner/serve_many_coffees.feature'
    end
  end
end