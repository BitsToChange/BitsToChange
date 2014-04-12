Feature: charity administrator deletes charity
  In order to remove test charities
  As a charity administrator
  I want to delete a charity

  Scenario: all is good
    Given I am already logged in with a charity administrator account
    And a charity exists
    When I delete that charity
    Then that charity is deleted

  Scenario: unfound charity
    Given I am already logged in with a charity administrator account
    And no charities exist
    When I go to delete a charity with id 5000
    Then I am told that charity does not exist
