Feature: User Authentication

  Scenario: A user visits the home page
    Given I visit the home page before signing up
    Then I should not be logged in

  Scenario: A user signs up
    Given I fill out the signup form
    Then my user account should be created
    And I should be logged in

  Scenario: A user signs out
    Given I am signed in
    When I sign out
    Then I should be taken to the home page
    And I should be logged out