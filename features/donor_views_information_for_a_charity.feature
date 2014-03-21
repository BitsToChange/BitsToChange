Feature: donor views information for a charity
  In order to find out more information about a charity
  As a donor
  I want to view the charity's information

  Scenario: the charity exists
    Given a charity exists
    When I go to that charity's page
    Then I see information for that charity

  Scenario: the charity does not exist
    Given no charities exist
    When I go to the page for charity 5000
    Then I am told that charity does not exist
