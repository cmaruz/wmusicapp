require 'spec_helper'

describe UsersController do

  describe "GET new" do
    
    let(:user) {user = mock_model(User)}

    it "creates a new user object" do
      User.should_receive(:new).and_return user
      get :new
    end

    it "returns the user object to the view" do
      User.stub(:new).and_return user
      get :new
      assigns(:user).should == user
    end
  end

  describe "POST create" do

    before :each do 
      @user = mock_model(User).as_null_object
      User.stub(:new).and_return @user
    end

    it "should create a new object from the given parameters" do
      User.should_receive(:new).with post_parameters["user"]
      post :create, post_parameters
    end

    context 'user saves successfully' do

      before :each do 
        @user.stub(:save).and_return true
      end

      it "should save the user" do
        @user.should_receive(:save)
        post :create
      end

      it "should redirect to the albums list" do
        post :create
        response.should redirect_to albums_path
      end

      it "should login the user" do
        post :create
        session[:user_id].should == @user.id 
      end
    end

    context 'user doesn\'t save successfully' do
      before :each do
        @user.stub(:save).and_return false
      end

      it "should not save the user object" do
        @user.should_receive(:save).and_return false
        post :create
      end

      it "should redirect to the signup page" do
        post :create
        response.should render_template :new
      end

      it "should show an error message" do
        post :create
        flash[:error].should_not be_blank
      end

    end

    def post_parameters
      {"user" => {"email" => 'mario.caropreso@gmail.com', "password" => 'password'}}
    end



  end

  

end
