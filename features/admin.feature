Feature: Admin

  Background:
    Given I am an admin

  Scenario: Admin user login
    Then I login as an admin

  Scenario: Admin can logout
    Then I should be able to logout