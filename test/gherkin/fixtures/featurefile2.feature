Feature: Serve super coffee

  Background:
    Given supper coffee

  Scenario: Buy last super coffee
    Given there are 1 super coffees left in the machine
    And I have deposited 10$
    When I press the super coffee button I have a cup
    Then I should be served a super coffee

  Scenario: No super coffee
    Given there are 1 coffees left in the machine
    And I have deposited 1$
    When I press the coffee button
    Then I should be served a coffee