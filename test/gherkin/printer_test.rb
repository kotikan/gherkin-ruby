# @author: Anders Murphy

require_relative '../test_helper'

module GherkinRuby
  describe 'write AST(feature as root node) object to directory' do
    before do
      feature1 = IO.read(File.dirname(__FILE__) + '/fixtures/serve_coffee.feature')

      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::Printer.new

      ast = parser.parse(feature1)
      printer.print_feature(ast, 'temp/')

      @result = IO.read('temp/serve_coffee.feature')
    end

    it 'prints a nice feature file' do
      @result.must_equal('Feature: Serve coffee

  Background:
    Given coffee

  @coffeeshop
  Scenario: Buy last coffee
    Given there are 1 coffees left in the machine
    And I have deposited 1$
    When I press the coffee button
    Then I should be served a coffee

  Scenario: No coffee
    Given there are 1 coffees left in the machine
    And I have deposited 1$
    When I press the coffee button
    Then I should be served a coffee
')
    end
  end

  describe 'write AST(feature group as root node) object to directory' do
    before do
      path = 'temp/'
      feature1 =IO.read(File.dirname(__FILE__) + '/fixtures/serve_coffee.feature')
      feature2 = IO.read(File.dirname(__FILE__) + '/fixtures/serve_super_coffee.feature')
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::Printer.new
      feature_group1 = GherkinRuby::AST::FeatureGroup.new('Nested Nested Feature Group',
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                                                       parser.parse(feature2)])
      feature_group2 = GherkinRuby::AST::FeatureGroup.new('Nested Feature Group',
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                          feature_group1])
      feature_group3 = GherkinRuby::AST::FeatureGroup.new('Feature Group',
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                                                       feature_group2])

      printer.print_feature_group(feature_group3, path)

    end

    it 'prints the right folder structure' do
      path = 'temp/'
      File.exist?(path + 'feature_group').must_equal(true)
      File.exists?(path + 'feature_group/serve_coffee.feature').must_equal(true)
      File.exist?(path + 'feature_group/nested_feature_group').must_equal(true)
      File.exists?(path + 'feature_group/nested_feature_group/serve_coffee.feature').must_equal(true)
      File.exist?(path + 'feature_group/nested_feature_group/nested_nested_feature_group').must_equal(true)
      File.exists?(path + 'feature_group/nested_feature_group/nested_nested_feature_group/serve_coffee.feature').must_equal(true)
      File.exists?(path + 'feature_group/nested_feature_group/nested_nested_feature_group/serve_super_coffee.feature').must_equal(true)
      #Empty temp directory after test
      FileUtils.rm_rf(Dir.glob('temp/*'))
    end


  end
end