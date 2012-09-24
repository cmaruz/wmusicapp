require 'spec_helper'

describe SessionsController do

  describe "POST create" do

    before :each do 
      @user = mock_model(User).as_null_object
      User.stub(:find_by_email).and_return @user
    end

    it "should find the object by email" do
      User.should_receive(:find_by_email).with post_parameters["email"]
      post :create, post_parameters
    end

    it "should call the authenticate method" do
      @user.should_receive(:authenticate).with post_parameters["password"]
      post :create, post_parameters
    end

    context 'valid login credentials' do

      before :each do 
        @user.stub(:authenticate).and_return true
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

    context 'invalid login credentials' do
      before :each do
        @user.stub(:authenticate).and_return false
      end

      it "should redirect to the signin page" do
        post :create
        response.should render_template :new
      end

      it "should show an error message" do
        post :create
        flash[:error].should_not be_blank
      end

    end

    def post_parameters
      {"email" => 'mario.caropreso@gmail.com', "password" => 'password'}
    end
  end

  describe "DELETE destroy" do 

    it "should destroy user session" do
      delete :destroy,nil,{:user_id => 1}
      session[:user_id].should be_blank
    end

    it "should redirect to signin page" do
      delete :destroy
      response.should redirect_to signin_path
    end
  end

end
