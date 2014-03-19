Feature: admin logs in
  In order to perform administrative duties on the site
  As a administrator
  I want to log in

  Scenario: the information is correct
    Given a user exists
    When I log in with that user's information
    Then I am logged in
    And I am not told that my credentials are bad
    And I am on the home page

  Scenario: bad password
    Given a user exists
    When I log in with that user's information with a bad password
    Then I am told that my credentials are bad
    And I am not logged in
    And I am on the login page

  Scenario: bad username
    Given a user exists
    When I log in with that user's information with a bad username
    Then I am told that my credentials are bad
    And I am not logged in
    And I am on the login page

  Scenario: no users
    Given no users exist
    When I log in with random information
    Then I am told that my credentials are bad
    And I am not logged in
    And I am on the login page

  Scenario: random info with users
    Given a user exists
    When I log in with random information
    Then I am told that my credentials are bad
    And I am not logged in
    And I am on the login page

  Scenario: no bad credentials without login attempt
    When I go to the login page
    Then I am not told that my credentials are bad