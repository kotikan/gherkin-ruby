Feature: Serve many coffees

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
      | Type          | Ingredient  |
      | mocha         | cocoa       |
      | caramel-latte | syrup       |
