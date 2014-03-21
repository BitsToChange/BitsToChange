Feature: charity registrar edits charity
  In order to keep charity's information up to date
  As a charity registrar
  I want to edit charity information

  Scenario: all is good
    Given I am already logged in with a charity registrar account
    And a charity exists
    When I edit that charity
    Then that charity is updated

  Scenario: incorrect account type
    Given I am already logged in
    And a charity exists
    When I go to edit that charity
    Then I am told I do not have permission to do that

  Scenario: not logged in
    Given I am already logged out
    And a charity exists
    When I go to edit that charity
    Then I am told I do not have permission to do that

  Scenario: unfound charity
    Given I am already logged in with a charity registrar account
    And no charities exist
    When I go to edit a charity with id 5000
    Then I am told that charity does not exist
