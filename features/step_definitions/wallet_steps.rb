And(/^no wallets exist$/) do
  Wallet.destroy_all
end

When(/^I generate a wallet for that charity$/) do
  visit charity_path @charity
  click_button 'Generate Wallet'
end

Then(/^that charity has a wallet$/) do
  @charity.wallets.length.should == 1
  @wallet = @charity.wallets.first
end

When(/^I try to generate a wallet for that charity$/) do
  visit generate_wallet_charity_path @charity
end

And(/^that charity already has a wallet$/) do
  @charity.wallets << create(:wallet)
end

Then(/^I am told that charity already has a wallet$/) do
  page.should have_content 'That charity already has a wallet.'
end

And(/^that wallet's public key matches what is expected by the generator$/) do
  path = "m/0/0/#{@charity.id}"
  master_node = MoneyTree::Node.from_serialized_address Constants::ROOT_SERIALIZED_ADDRESS
  @wallet.public_key.should == master_node.node_for_path(path).to_address
end