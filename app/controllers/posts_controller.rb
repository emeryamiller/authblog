class PostsController < ApplicationController
  before_filter :grab_post, :only => [:show, :edit, :update, :delete]
  
  def index
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.save
    flash[:notice] = "Post has been created."
    redirect_to @post
  end

  def show
  end

  private
  def grab_post
    @post = Post.find_by_title(params[:id])
    @post = Post.find(params[:id]) unless @post
  end
end
