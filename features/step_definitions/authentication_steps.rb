Given /^I don't have a user account$/ do
  User.count.should == 0
end

When /^I create an account by providing my email and password$/ do
  visit signup_path
  fill_in "user_email", :with => 'mario.caropreso@gmail.com'
  fill_in "user_password", :with => 'password'
  click_button "Sign up"
end

Then /^I should have a new account$/ do
  User.count.should == 1
end

Then /^I should see my albums page$/ do
  current_url.should =~ /#{albums_path}/
end

When /^I create an account by providing a wrong email address$/ do
  visit signup_path
  fill_in "user_email", :with => 'mario.caropreso'
  fill_in "user_password", :with => 'password'
  click_button "Sign up"
end

Then /^I shouldn't have a new account$/ do
  User.count.should == 0
end

Then /^I should see an error message$/ do
  page.should have_selector "#error"
end

Given /^I have a valid account$/ do
  @user = User.create(valid_credentials)
  @user.save
end

When /^I insert my login credentials$/ do
  visit signin_path
  fill_in "email", :with => valid_credentials[:email]
  fill_in "password", :with => valid_credentials[:password]
  click_button "Log in"
end

Then /^I should see my album collections$/ do
  current_url.should =~ /#{albums_path}/
end

When /^I insert a wrong password$/ do
  visit signin_path
  fill_in "email", :with => "mario.caropreso@gmail.com"
  fill_in "password", :with => "wrong password"
  click_button "Log in"
end

Then /^I shouldn't be logged in$/ do
  page.should have_content("Log in")
end

Given /^I am a logged user$/ do
  @user = User.create(valid_credentials)
  @user.save
  visit signin_path
  fill_in "email", :with => valid_credentials[:email]
  fill_in "password", :with => valid_credentials[:password]
  click_button "Log in"
  current_url.should =~ /#{albums_path}/
end

When /^I click on the logout button$/ do
  visit albums_path
  click_link "Logout"
end

def valid_credentials
  {:email => "mario.caropreso@gmail.com", :password => "password"}
end