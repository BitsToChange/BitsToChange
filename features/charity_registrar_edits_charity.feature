Feature: charity registrar edits charity
  In order to keep charity's information up to date
  As a charity registrar
  I want to edit charity information

  Scenario: all is good
    Given I am already logged in with a charity registrar account
    And a charity exists
    When I edit that charity
    Then that charity is updated

  Scenario: unfound charity
    Given I am already logged in with a charity registrar account
    And no charities exist
    When I go to edit a charity with id 5000
    Then I am told that charity does not exist
