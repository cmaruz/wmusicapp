Given /^I am logged in as "(.*?)"$/ do |arg1|
  @user = User.create(valid_credentials)
  @user.save
  visit signin_path
  fill_in "email", :with => valid_credentials[:email]
  fill_in "password", :with => valid_credentials[:password]
  click_button "Log in"
  current_url.should =~ /#{albums_path}/
end

Given /^I have two albums$/ do |table|
  table.hashes.each do |hash|
  	@user.albums.create!(:title => hash[:title], :cover => File.open("#{Rails.root}/spec/fixtures/#{hash[:cover]}"))
  end
  @user.albums.count.should == 2
end

When /^I go to the albums list$/ do
  visit albums_path
end

Then /^I can see the albums "(.*?)" and "(.*?)"$/ do |arg1, arg2|
  page.should have_content arg1
  page.should have_content arg2
end

Then /^I should see minified cover images$/ do
  page.should have_selector('img[width="200"][height="200"]',:count => 2)
end

Given /^I have no albums$/ do
  @user.albums.count.should == 0
end

Then /^I see an empty album list$/ do
  page.should have_content("You haven't added any album yet")
end

When /^I add the album "(.*?)" with cover "(.*?)"$/ do |arg1, arg2|
  click_link "Add a new album"
  fill_in "album_title", :with => arg1
  attach_file "album_cover", "#{Rails.root}/spec/fixtures/#{arg2}"
  click_button "Add the album"
end

Then /^I can see the album "(.*?)" in the albums list$/ do |arg1|
  visit albums_path
  page.should have_content arg1
end

When /^I add the album "(.*?)" with cover not in an image format$/ do |arg1|
  click_link "Add a new album"
  fill_in "album_title", :with => arg1
  attach_file "album_cover", "#{Rails.root}/spec/fixtures/test.docx"
  click_button "Add the album"
end

Then /^the album shouldn't be added$/ do
  page.should have_content "Please provide valid data"
end

Given /^I have the album "(.*?)"$/ do |arg1|
  @user.albums.create(:title => arg1, :cover => File.open("#{Rails.root}/spec/fixtures/negramaro_casa_69.jpg"))
end

Then /^I should see an error of duplicated album$/ do
  page.should have_content "Please provide valid data"
end

When /^I search for the album "(.*?)"$/ do |arg1|
  fill_in "query", :with => arg1
  click_button "Search"
end

Then /^I should see the album "(.*?)" in the search results$/ do |arg1|
  page.should have_content arg1
end

Then /^I should see an empty results list$/ do
  page.should have_content "No albums found"
end



def valid_credentials
  {:email => "mario.caropreso@gmail.com", :password => "password"}
end
