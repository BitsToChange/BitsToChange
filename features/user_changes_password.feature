Feature: user changes password
  In order to ensure the security of my account
  As an admin
  I want to change my password

  Scenario: good everything
    Given I am already logged in
    When I change my password
    Then I am on the home page
    And I can log in with my new password
    And I cannot log in with my old password

  Scenario: bad new password confirmation
    Given I am already logged in
    When I change my password but mess up the new password confirmation
    Then I am told my confirmation was incorrect

  Scenario: bad old password
    Given I am already logged in
    When I change my password but mess up the old password
    Then I am told my old password was incorrect

  Scenario: not logged in
    Given I am already logged out
    When I go to change my password
    Then I am on the login page
