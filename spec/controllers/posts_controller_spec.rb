require 'spec_helper'

describe PostsController do
  it "displays an error message when asked for a missing post" do
    get :show, :id => "not-here"
    response.should redirect_to(posts_path)
    flash[:alert].should eql("The post you were looking for could not be found.")
  end
end
