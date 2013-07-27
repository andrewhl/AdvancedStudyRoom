Feature: A user can signup
  In order to do stuff
  As a visitor
  I should be able to create an account

  Scenario: Visitor signs up with valid data
    When I go to the sign up page
    And I sign up with "email@example.com" and "password"
    Then I should be signed in
