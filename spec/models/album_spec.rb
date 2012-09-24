require 'spec_helper'

describe Album do
  before :each do 
  	@album = Album.create!(:title => "Mentre tutto scorre", :cover => File.open("#{Rails.root}/spec/fixtures/negramaro_casa_69.jpg"),:user_id => 1)
  end

  it "should be invalid without a title" do
  	@album.title = nil
  	@album.should_not be_valid
  end

  it "should be invalid without a cover" do
  	@album.remove_cover!
  	@album.should_not be_valid
  end

  it "should have a unique title" do
  	new_album = Album.create(:title => "Mentre tutto scorre", :cover => File.open("#{Rails.root}/spec/fixtures/negramaro_casa_69.jpg"),:user_id => 1)
  	@album.save
  	new_album.should_not be_valid
  end

  it "should be valid with valid data" do
  	@album.should be_valid
  end

  

end
