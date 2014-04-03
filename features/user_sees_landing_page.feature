Feature: user sees landing page
  In order to learn more about Bits to Change
  As a user
  I want to see a landing page

  Scenario: it's the only one
    When I go to the root page
    Then I see the title as "Bits to Change"
    And I see "Giving the change to those who make the change."
