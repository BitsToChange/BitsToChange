When(/^I sign up for the mailing list$/) do
  @email = 'some@email.com'
  signup_for_mailing_list(@email)
end

def signup_for_mailing_list(email)
  visit root_url
  fill_in 'mailing_email', :with => email
  click_button 'loop'
end

When(/^I sign up for the mailing list with that email$/) do
  signup_for_mailing_list(@email)
end

And(/^I am told I have been signed up for the mailing list$/) do
  page.should have_content 'You have been signed up for the mailing list.'
end

Then(/^I am told I am already signed up for the mailing list$/) do
  page.should have_content 'You are already signed up for the mailing list.'
end