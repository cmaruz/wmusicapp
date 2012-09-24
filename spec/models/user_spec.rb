require 'spec_helper'

describe User do
  
  before :each do 
  	@user = User.create(:email => 'mario.caropreso@gmail.com', :password => 'password', :password_confirmation => 'password')
  end

  it "should be invalid without an email address" do
  	@user.email = nil
  	@user.should_not be_valid
  end

  it "should be invalid with an invalid email address" do
  	@user.email = 'mario.caropreso'
  	@user.should_not be_valid
  end

  it "should have a unique email address" do
  	new_user = User.create(:email => 'mario.caropreso@gmail.com', :password => 'password')
  	@user.save
  	new_user.should_not be_valid
  end

  it "should be invalid if password confirmation does not match" do
  	@user.password_confirmation = "password2"
  	@user.should_not be_valid
  end

  it "should be valid with a valid email address" do
  	@user.should be_valid
  end

  it "should be invalid with an empty password" do
  	@user.password = ""
  	@user.should_not be_valid
  end

end
