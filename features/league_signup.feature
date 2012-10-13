Feature: League Signup

  Background:
    Given I am a user
    And I login as a user

  Scenario: A user can create a server account
    When I visit the new account page
    Then I create an account

  Scenario: A user can signup for the league
    When I visit the league registration page
    Then I signup for the league