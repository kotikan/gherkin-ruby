gem 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/gherkin_ruby'

module Helpers
  def create_feature
    'Feature: Serve coffee

  Background:
    Given coffee

  @coffeeshop
  Scenario: Buy last coffee
    Given there are 1 coffees left in the machine
      And I have deposited $1
     When I press the coffee button
     Then I should be served a coffee

  Scenario: No coffee
    Given there are 1 coffees left in the machine
      And I have deposited 1$
     When I press the coffee button
     Then I should be served a coffee
'
  end

  def create_feature_with_scenario_outline
    'Feature: Serve many coffees

  Background:
    Given coffee

  @coffeeshop
  Scenario Outline: Buy coffee type
    Given I order a <Type>
      And I have deposited $1
     When I press the coffee button
     Then I should be served a coffee
      And it should contain <Ingredient>
    Examples:
      | Type          | Ingredient |
      | mocha         | cocoa      |
      | caramel-latte | syrup      |
'
  end

  def create_feature_with_doc_string
    'Feature: Serve coffee

  Background:
    Given coffee

  @coffeeshop
  Scenario: Buy last coffee
    Given there are 1 coffees left in the machine
      And I have deposited $1
      """
      A doc string
      in this step
      """
     When I press the coffee button
     Then I should be served a coffee

  Scenario: No coffee
    Given there are 1 coffees left in the machine
      And I have deposited 1$
     When I press the coffee button
     Then I should be served a coffee
'
  end

  def create_feature_with_table
    'Feature: Serve coffee

  Background:
    Given coffee

  @coffeeshop
  Scenario: Buy last coffee
    Given there are 1 coffees left in the machine
      And I have deposited $1
      | a   | table |
      | foo | bar   |
     When I press the coffee button
     Then I should be served a coffee

  Scenario: No coffee
    Given there are 1 coffees left in the machine
      And I have deposited 1$
     When I press the coffee button
     Then I should be served a coffee
'
  end
end
