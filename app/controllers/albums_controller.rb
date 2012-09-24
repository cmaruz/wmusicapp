class AlbumsController < ApplicationController
	before_filter :authenticate
	
  def index
  	@albums = current_user.albums
  end

  def new
  	@album = Album.new
  end

  def create
  	@album = Album.new(params[:album])
  	current_user.albums << @album

  	if @album.save
  		redirect_to albums_path
  	else
  		flash.now[:error] = "Please provide valid data"
  		render :action => :new
  	end
  end

  def search
  	@albums = Album.where('user_id = :id AND title LIKE :title',{:id => current_user.id,:title => "%#{params[:query]}%"})
    p current_user.id
    p params[:query]
  end
end
