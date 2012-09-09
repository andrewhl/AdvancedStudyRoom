Feature: League Signup

  Scenario: A user can signup for the league
    Given I am a user
    And I login as a user
    When I visit the league registration page
    Then I signup for the league