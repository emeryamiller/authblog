class PostsController < ApplicationController
  before_filter :grab_post, :only => [:show, :edit, :update, :delete]
  
  def index
    
  end

  def new
    @post = Post.new
  end

  def create
    puts params
    @post = Post.new(params[:post])
    @post.save
    flash[:notice] = "Post has been created."
    redirect_to @post
  end

  def show
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
