Feature: admin logs out
  In order to keep my account secure
  As a admin
  I want to log out

  Scenario: logged in
    Given I am already logged in
    When I log out
    Then I am not logged in
    And I am on the home page

  Scenario: logged out
    Given I am already logged out
    When I log out
    Then I am not logged in
    And I am on the home page