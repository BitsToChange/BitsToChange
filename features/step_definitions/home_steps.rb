When(/^I go to the root page$/) do
  visit '/'
end

Then(/^I see the title as "([^"]*)"$/) do |title|
  page.should have_title title
end

Then(/^I see "([^"]*)"$/) do |text|
  page.should have_content text
end

And(/^I am on the home page$/) do
  uri = URI.parse current_url
  uri.path.should == '/'
end