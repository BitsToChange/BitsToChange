Feature: donor sees list of charities
  In order to find a charity I like
  As a donor
  I want to see a list of charities

  Scenario: no charities
    Given no charities exist
    When I see the list of charities
    Then I am told there are no charities

  Scenario: many charities
    Given 5 charities exist
    When I see the list of charities
    Then I see the charities
