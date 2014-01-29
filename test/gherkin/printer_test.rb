# @author: Anders Murphy

require_relative '../test_helper'

module GherkinRuby
  describe 'write AST object to directory' do
    before do
      scenario = """Feature: My Feature
  In order to do something #w000t peoeple
  As a developer
  I want to be happy #yeah

  # Attend people. This is going to be fun

  Background:
    Given something happens before anything else happens
    And more things happens before anything else happens
    # And I wipe the hard drive

  Scenario: something happens # yeah
    Given something happens
    Then something cooler happens

  @javascript @wip #@destroy
  Scenario: something else happens
    Given foo
    Then bar
"""

      parser = GherkinRuby::Parser.new
      printer = GherkinRuby::Printer.new
      ast = parser.parse(scenario)
      path = 'Documents/'
      printer.print(ast, path)
      @result = File.read(ENV['HOME'] + "/#{path}#{ast.instance_variable_get('@name')}.feature")
    end

    it 'prints a nice feature file' do
      @result.must_equal( """Feature: My Feature

  Background:
    Given something happens before anything else happens
    And more things happens before anything else happens

  Scenario: something happens
    Given something happens
    Then something cooler happens

  Scenario: something else happens
    Given foo
    Then bar
""")
    end
  end
end