When(/^I add a new charity$/) do
  visit new_charity_path
  fill_in 'Name', :with => 'Bob\'s Bait and Tackle for the homeless'
  fill_in 'Description', :with => 'Bob\'s Bait and Tackle is an awesome place to get bait and tackle.'
  fill_in 'Website', :with => 'http://bobsbaitandtackle.com'
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
  @charities = []
  number.to_i.times do
    @charities << Charity.create(name: "Charity#{number}", description: "Charity #{number} is awesome!")
  end
end

Then(/^I see the charities$/) do
  @charities.each do |charity|
    page.should have_content charity.name
  end
end

Given(/^a charity exists$/) do
  @charity = Charity.create!(name: 'Charity', description: 'Charity is awesome!', website: 'somewhere.com')
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
