Feature: charity registrar deletes charity
  In order to remove test charities
  As a charity registrar
  I want to delete a charity

  Scenario: all is good
    Given I am already logged in with a charity registrar account
    And a charity exists
    When I delete that charity
    Then that charity is deleted

  Scenario: incorrect account type
    Given I am already logged in
    And a charity exists
    When I go to delete that charity
    Then I am told I do not have permission to do that

  Scenario: not logged in
    Given I am already logged out
    And a charity exists
    When I go to delete that charity
    Then I am told I do not have permission to do that

  Scenario: unfound charity
    Given I am already logged in with a charity registrar account
    And no charities exist
    When I go to delete a charity with id 5000
    Then I am told that charity does not exist
