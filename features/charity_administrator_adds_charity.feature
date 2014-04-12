Feature: charity administrator adds charity
  In order to give donors a charity to donate to
  As a charity administrator
  I want to add a charity

  Scenario: all is good
    Given I am already logged in with a charity administrator account
    When I add a new charity
    Then there is a new charity
