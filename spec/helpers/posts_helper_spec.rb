require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe PostsHelper do
  describe "content methods" do
    it "should return the full markdown content of the article without <html> or <body> headers" do
      @post = Factory.create(:post, :title => "A new post", :blog => 'blog post')
      full_content = markdown(@post.full_post)
      full_content.should_not match(/<html>/)
      full_content.should_not match(/<body>/)
      full_content.should match(/<h1>A new post/)
      full_content.should match(/blog post/)
    end

    it "should return safe html" do
      @post = Factory.create(:post, :title => "A new post", :blog => 'blog post')
      full_content = markdown(@post.full_post)
      full_content.html_safe?.should == true
      abstract = abstract_markdown(@post.abstract)
      abstract.html_safe?.should == true
    end

    it "shouldn't have any rich elements" do
      @post = Factory.create(:post, :blog => "An image ![](images/google_64.png) [hard](http://www.google.com)")
      abstract = abstract_markdown(@post.abstract)
      abstract.should_not match /<img>/
      abstract.should_not match /\!\[\]/
      abstract.should == "<p>An image  </p>\n"
    end
  end
end
