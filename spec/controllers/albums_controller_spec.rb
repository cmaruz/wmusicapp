require 'spec_helper'

describe AlbumsController do

  before :each do
    @user = mock_model(User).as_null_object
    session[:user_id] = @user.id 
    User.stub(:find).and_return @user
  end

  describe "GET 'index'" do

    before :each do 
      @albums = Array.new
      @albums << Album.create(album_collection[0])
      @albums << Album.create(album_collection[1])
      @user.stub(:albums).and_return @albums
    end
    
    it "should find all the current user albums" do
      @user.should_receive(:albums).and_return @albums
      get :index
    end

    it "should assigns the albums variable" do
      get :index
      assigns(:albums).should eq(@albums)
    end

  end

  describe "GET new" do

    it "should assign the album variable" do
      get :new
      assigns(:album).should be
    end
  end

  describe "POST create" do

    before :each do 
      @album = mock_model(Album).as_null_object
      Album.stub(:new).and_return @album
    end

    it "should create a new object from the given parameters" do
      Album.should_receive(:new).with post_parameters["album"]
      post :create, post_parameters
    end

    context 'album saves successfully' do

      before :each do 
        @album.stub(:save).and_return true
      end

      it "should save the album" do
        @album.should_receive(:save)
        post :create
      end

      it "should redirect to the albums list" do
        post :create
        response.should redirect_to albums_path
      end

    end

    context 'album doesn\'t save successfully' do
      before :each do
        @album.stub(:save).and_return false
      end

      it "should not save the album object" do
        @album.should_receive(:save).and_return false
        post :create
      end

      it "should render to the add form" do
        post :create
        response.should render_template :new
      end

      it "should show an error message" do
        post :create
        flash[:error].should_not be_blank
      end

    end


    def post_parameters
      {"album" => {"title" => "Mentre tutto scorre", "cover" => "negramaro_mentre_tutto_scorre.jpg"}}
    end
  end

  describe "POST search" do

    before :each do 
      @album = mock_model(Album).as_null_object
      Album.stub(:where).and_return @album
    end

    it "should call the where method" do
      Album.should_receive(:where)
      post :search, {:query => "tutto scorre"}
    end

    it "should assign the albums variables" do
      post :search, {:query => "tutto scorre"}
      assigns(:albums).should eq(@album)
    end

  end

  def album_collection
    [{:title => "Mentre tutto scorre", :cover => "negramaro_mentre_tutto_scorre.jpg",:user_id => @user.id},
     {:title => "Casa 69", :cover => "negramaro_casa_69",:user_id => @user.id}]
  end
end
