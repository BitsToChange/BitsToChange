def fill_in_charity_information(options = {})
  fill_in 'Name', :with => options[:name] || 'Bob\'s Bait and Tackle for the homeless'
  fill_in 'Description', :with => options[:description] || 'Bob\'s Bait and Tackle is an awesome place to get bait and tackle.'
  fill_in 'Website', :with => options[:website] || 'http://bobsbaitandtackle.com'
end

When(/^I add a new charity$/) do
  visit new_charity_path
  fill_in_charity_information
  click_button 'Create'
end

Then(/^there is a new charity$/) do
  Charity.count.should > 0
end

When(/^I go to add a new charity$/) do
  visit new_charity_path
end

Given(/^no charities exist$/) do
  Charity.destroy_all
end

When(/^I see the list of charities$/) do
  visit charities_path
end

Then(/^I am told there are no charities$/) do
  page.should have_content 'We don\'t have any charities yet.'
end

Given(/^(\d+) charities exist$/) do |number|
  @charities = (0..number.to_i).map.inject([]) do |list, number|
    list << create(:charity)
  end
end

Then(/^I see the charities$/) do
  @charities.each do |charity|
    page.should have_content charity.name
  end
end

Given(/^a charity exists$/) do
  @charity = create :charity
end

When(/^I go to that charity's page$/) do
  visit charity_path(@charity)
end

Then(/^I see information for that charity$/) do
  page.should have_content @charity.name
  page.should have_content @charity.description
  page.should have_link @charity.website
end

When(/^I go to the page for charity (\d+)$/) do |number|
  visit charity_path number
end

Then(/^I am told that charity does not exist$/) do
  page.should have_content 'We cannot find that charity.'
end


When(/^I edit that charity$/) do
  visit edit_charity_path @charity
  @updatedCharity = @charity
  @updatedCharity.name += 'something'
  @updatedCharity.description += 'something'
  @updatedCharity.website += 'something'
  fill_in_charity_information @updatedCharity
  click_button 'Update'
end

Then(/^that charity is updated$/) do
  changedCharity = Charity.find @charity.id
  changedCharity.name.should == @updatedCharity.name
  changedCharity.description.should == @updatedCharity.description
  changedCharity.website.should == @updatedCharity.website
end

When(/^I go to edit that charity$/) do
  visit edit_charity_path @charity
end

def delete_charity(charity = @charity)
  page.driver.submit :delete, charity_path(charity), {}
end

When(/^I delete that charity$/) do
  delete_charity
end

Then(/^that charity is deleted$/) do
  Charity.exists?(@charity).should == false
end

When(/^I go to edit a charity with id (\d+)$/) do |id|
  visit edit_charity_path id
end

When(/^I go to delete that charity$/) do
  delete_charity
end

When(/^I go to delete a charity with id (\d+)$/) do |id|
  delete_charity id
end