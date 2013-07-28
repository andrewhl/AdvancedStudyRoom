Feature: A user can login
  In order to access user features
  As a visitor
  I should be able to login

  Scenario: Visitor logs in with valid data
    When I go to the login page
    And I login with "email@example.com" and "password"
    Then I should be signed in

  Scenario: Visitor attempts to log in with invalid data
    When I go to the login page
    And I login with "foo@example.fuz" and "barbar"
    Then I should not be signed in