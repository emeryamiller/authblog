class PostsController < ApplicationController
  before_filter :grab_post, :only => [:show, :edit, :update, :delete]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    puts params
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
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to posts_path
  end

  private
  def grab_post
    if params[:id].numeric?
      @post = Post.find(params[:id])
    else
      @post = Post.find_by_title!(params[:id])
    end
  end
end
