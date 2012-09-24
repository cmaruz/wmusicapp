class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
  		create_user_session(@user)
  		redirect_to albums_path
  	else
  		flash.now[:error] = "Please provide a valid email address"
  		render :action => :new
  	end
  end
end
