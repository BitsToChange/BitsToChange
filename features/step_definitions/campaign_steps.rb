When(/^I create a campaign for that charity$/) do
  visit new_charity_campaign_path(@charity)
  campaign = build(:campaign)
  fill_in 'Name', :with => campaign.name
  fill_in 'Description', :with => campaign.description
  fill_in 'Goal', :with => campaign.goal
  click_button 'Create'
end

Then(/^that charity has a campaign$/) do
  @charity.campaigns.size.should == 1
  @campaign = @charity.campaigns.first
end