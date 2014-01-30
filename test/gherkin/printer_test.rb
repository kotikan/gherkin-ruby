# @author: Anders Murphy

require_relative '../test_helper'

module GherkinRuby
  describe 'write AST(feature as root node) object to directory' do
    before do
      feature1 = File.read('fixtures/featurefile1.feature')
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::Printer.new
      ast = parser.parse(feature1)
      path = 'Documents/'
      printer.print_feature(ast, path)
      @result = File.read(ENV['HOME'] + "/#{path}#{ast.name}.feature")
    end

    it 'prints a nice feature file' do
      @result.must_equal( """Feature: Serve coffee

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
""")
    end
  end

  describe 'write AST(feature group as root node) object to directory' do
    before do
      path = 'Documents/'
      feature1 = File.read('fixtures/featurefile1.feature')
      feature2 = File.read('fixtures/featurefile2.feature')
      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::Printer.new
      feature_group1 = GherkinRuby::AST::FeatureGroup.new("Nested Nested Feature Group",
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                                                       parser.parse(feature2)])
      feature_group2 = GherkinRuby::AST::FeatureGroup.new("Nested Feature Group2",
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                          feature_group1])
      feature_group3 = GherkinRuby::AST::FeatureGroup.new("Feature Group",
                                                          features_and_feature_groups=[parser.parse(feature1),
                                                                                       feature_group2])

      printer.print_feature_group(feature_group3, path)

    end

    it 'prints the right folder structure' do
      path = 'Documents/'
      File.exist?(ENV['HOME'] + "/#{path}Feature Group").must_equal(true)
      File.exists?(ENV['HOME'] + "/#{path}Feature Group/Serve coffee.feature").must_equal(true)
      File.exist?(ENV['HOME'] + "/#{path}Feature Group/Nested Feature Group").must_equal(true)
      File.exists?(ENV['HOME'] + "/#{path}Feature Group/Nested Feature Group/Serve coffee.feature").must_equal(true)
      File.exist?(ENV['HOME'] + "/#{path}Feature Group/Nested Feature Group/Nested Nested Feature Group").must_equal(true)
      File.exists?(ENV['HOME'] + "/#{path}Feature Group/Nested Feature Group/Nested Nested Feature Group/Serve coffee.feature").must_equal(true)
      File.exists?(ENV['HOME'] + "/#{path}Feature Group/Nested Feature Group/Nested Nested Feature Group/Serve super coffee.feature").must_equal(true)
    end

  end
end