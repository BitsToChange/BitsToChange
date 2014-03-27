# CREATE USER

def create_user
  User.create!(email: 'admin@email.com', password: 'password', password_confirmation: 'password')
end

Given(/^a user exists$/) do
  @user = create_user
  @email = @user.email
end

Given(/^no users exist$/) do
  User.destroy_all
end

# LOGIN

def login_with(email, password)
  go_to_login
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button 'Log In'
end

def go_to_login
  visit login_path
end

def should_be_logged_in
  page.should have_content "Welcome #{@user.email}!"
end

def should_not_be_logged_in
  page.should_not have_content "Welcome"
end

When(/^I log in with that user's information$/) do
  login_with @user.email, @user.password
end

Then(/^I am( not)? logged in$/) do |notLoggedIn|
  if notLoggedIn
    should_not_be_logged_in
  else
    should_be_logged_in
  end
end

When(/^I log in with that user's information with a bad password$/) do
  login_with @user.email, @user.password + 'something bad'
end

When(/^I log in with that user's information with a bad email$/) do
  login_with @user.email + 'bad', @user.password
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
  login_with @user.email, @user.password
end

def login_with_roles(*roles)
  @user = create_user
  roles.each { |role|
    @user.roles.create!(name: role)
  }
  login_with @user.email, @user.password
end

Given(/^I am already logged in with a charity registrar account$/) do
  login_with_roles 'charity registrar'
end

Then(/^I am( not)? told that my credentials are bad$/) do |notBadCredentials|
  if notBadCredentials
    page.should_not have_content 'Invalid email and/or password.'
  else
    page.should have_content 'Invalid email and/or password.'
  end
end

# LOGOUT

When(/^I log out$/) do
  log_out
end

def log_out
  visit logout_path
end

Given(/^I am already logged out$/) do
  log_out
end

Then(/^I am( not)? told I do not have permission to do that$/) do |notTold|
  if notTold
    page.should_not have_content 'You do not have permission to do that.'
  else
    page.should have_content 'You do not have permission to do that.'
  end
end

# CHANGE PASSWORD

def change_password(options = {})
  @newPassword = options[:new_password] || @user.password + 'something'
  visit change_password_path
  fill_in 'Old', :with => options[:old_password] || @user.password
  fill_in 'New', :with => @newPassword
  fill_in 'Confirm', :with => options[:confirm_password] || @newPassword
  click_button 'Change'
end

When(/^I change my password$/) do
  change_password
end

Then(/^I can log in with my new password$/) do
  log_out
  login_with @user.email, @newPassword
  should_be_logged_in
end

And(/^I cannot log in with my old password$/) do
  log_out
  login_with @user.email, @user.password
  should_not_be_logged_in
end

When(/^I change my password but mess up the new password confirmation$/) do
  change_password :confirm_password => 'Something different'
end

Then(/^I am told my confirmation was incorrect$/) do
  page.should have_content 'Incorrect password confirmation.'
end

When(/^I change my password but mess up the old password$/) do
  change_password :old_password => @user.password + 'something else'
end

Then(/^I am told my old password was incorrect$/) do
  page.should have_content 'Incorrect old password.'
end

When(/^I go to change my password$/) do
  visit change_password_path
end

Then(/^I have an account$/) do
  @user = User.find_by_email(@email)
  @user.should_not be_nil
end

# SIGNUP

Then(/^I am identified through Segment.io$/) do
  firstIdentification = Analytics.identifications.first
  firstIdentification[:user_id].should == @user.id
  firstIdentification[:traits][:email].should == @email
  firstIdentification[:traits][:created_at].should == @user.created_at
end