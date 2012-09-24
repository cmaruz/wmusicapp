class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email(params[:email])

  	if @user && @user.authenticate(params[:password])
  		create_user_session(@user)
  		redirect_to albums_path
  	else
  		flash.now[:error] = "Please provide valid credentials"
  		render :action => "new"
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end
end
