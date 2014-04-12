Feature: charity administrator creates campaign for charity
  In order to begin a one off fundraising for a charity
  As a charity administrator
  I want to create a campaign for a charity

  Scenario: the charity has no campaigns
    Given a charity exists
    And I am already logged in with a charity administrator account
    When I create a campaign for that charity
    Then that charity has a campaign
    And that campaign has a wallet
    And that campaign's wallet's public key matches what is expected by the generator
