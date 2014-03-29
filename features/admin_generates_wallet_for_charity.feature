Feature: admin generates wallet for charity
  In order to allow people to donate to a charity
  As an administrator
  I want to generate a wallet for a charity

  Scenario: the charity doesn't have a wallet
    Given a charity exists
    And no wallets exist
    And I am already logged in with a charity registrar account
    When I generate a wallet for that charity
    Then that charity has a wallet
    And that wallet's public key matches what is expected by the generator

  Scenario: I am logged in with a bad account type
    Given a charity exists
    And no wallets exist
    And I am already logged in
    When I try to generate a wallet for that charity
    Then I am told I do not have permission to do that

  Scenario: I am not logged in
    Given a charity exists
    And no wallets exist
    And I am already logged out
    When I try to generate a wallet for that charity
    Then I am told I do not have permission to do that

  Scenario: the charity has a wallet
    Given a charity exists
    And that charity already has a wallet
    And I am already logged in with a charity registrar account
    When I try to generate a wallet for that charity
    Then I am told that charity already has a wallet
