Feature: potential user signs up through mailing list
  In order to stay up to date with bitstochange news
  As a potential user
  I would like to sign up for updates

  Scenario: email doesn't exist
    Given no users exist
    When I sign up for the mailing list
    Then I have an account
    And Segment.io is notified someone signed up
    And I am told I have been signed up for the mailing list

  Scenario: email does exist
    Given a user exists
    When I sign up for the mailing list with that email
    Then I am told I am already signed up for the mailing list
    And I have an account
    And Segment.io is not notified someone signed up
