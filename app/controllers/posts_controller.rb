class PostsController < ApplicationController
  before_filter :authorize_admin, :except => [:index, :show]
  before_filter :grab_post, :only => [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.readable_by(current_user).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Post has been created."
      redirect_to @post
    else
      flash[:alert] = "Post has not been created."
      render action:"new"
    end
  end

  def show
  end
  
  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice]= "Post has been updated."
      redirect_to @post
    else
      flash[:alert]= "Post has not been updated."
      render action:"edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to posts_path
  end

  private
  def grab_post
    if params[:id].numeric?
      @post = Post.readable_by(current_user).find(params[:id])
    else
      @post = Post.readable_by(current_user).find_by_title!(params[:id])
    end

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The post you were looking for could not be found."
    redirect_to posts_path
  end
end
