require 'spec_helper'

describe PostsController do
  let(:user) do
    user = Factory(:user)
    user.confirm!
    user
  end

  let(:blog_post) { Factory(:post)}

  context "standard users" do
    {"new" => "get",
     "create" => "post",
     "edit" => "get",
     "update" => "put",
     "destroy" => "delete"}.each do |action, method|
        it "cannot access the #{action} action" do
          sign_in(:user, user)
          send(method, action.dup, :id => blog_post.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You must be an admin to do that.")
        end
     end
  end

  it "displays an error message when asked for a missing post" do
    get :show, :id => "not-here"
    response.should redirect_to(posts_path)
    flash[:alert].should eql("The post you were looking for could not be found.")
  end
end
