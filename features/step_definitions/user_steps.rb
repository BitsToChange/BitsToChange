def create_user
  User.create!(username: 'Admin', password: 'password', password_confirmation: 'password')
end

Given(/^a user exists$/) do
  @user = create_user
end

Given(/^no users exist$/) do
  User.destroy_all
end

When(/^I log in with that user's information$/) do
  login_with @user.username, @user.password
end

def go_to_login
  visit login_path
end

def login_with(username, password)
  go_to_login
  fill_in 'Username', :with => username
  fill_in 'Password', :with => password
  click_button 'Log In'
end

Then(/^I am( not)? logged in$/) do |notLoggedIn|
  if notLoggedIn
    page.should_not have_content 'Welcome Admin!'
  else
    page.should have_content 'Welcome Admin!'
  end
end

When(/^I log in with that user's information with a bad password$/) do
  login_with @user.username, @user.password + 'something bad'
end

Then(/^I am( not)? told that my credentials are bad$/) do |notBadCredentials|
  if notBadCredentials
    page.should_not have_content 'Invalid username and/or password.'
  else
    page.should have_content 'Invalid username and/or password.'
  end
end


When(/^I log in with that user's information with a bad username$/) do
  login_with @user.username + 'bad', @user.password
end

When(/^I log in with random information$/) do
  #noinspection SpellCheckingInspection
  login_with 'asdfghjkl', 'qwertyuiop'
end


When(/^I go to the login page$/) do
  go_to_login
end

And(/^I am on the login page$/) do
  current_url.should match '/login'
end

Given(/^I am already logged in$/) do
  @user = create_user
  login_with @user.username, @user.password
end

When(/^I log out$/) do
  log_out
end

def log_out
  visit logout_path
end

Given(/^I am already logged out$/) do
  log_out
end