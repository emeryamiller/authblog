require 'spec_helper'

describe Post do
  describe "virtual attributes" do
    describe "date attributes" do
      before(:each) do
       @post = Factory.create(:post)
       @modified_post = Factory.create(:modified_post)
      end

      [:day, :month, :year].each do |date_part|
        it "should respond to the #{date_part} call with the #{date_part} the article was last modified" do
          @post.send(date_part).should == Time.now.send(date_part)
          @modified_post.send(date_part).should == Time.now.send(date_part)
        end
      end
    end

    describe "abstract method" do
      it "should return the first 2 sentances (it's less than 30 words)" do
        full_text = %Q(This is some blog content.  There can be tons of text, 
                       following the initial text, but only a certain amount 
                       should be included in the snippet on the web. At what 
                       point should it stop, should it say be as verbose as 
                       I am being now, or should it split at some point?)

        @post = Factory.create(:post, :blog => full_text)
        @post.abstract.should_not == full_text
        @post.abstract.scan(/\./).size.should == 2 
        @post.abstract.scan(/\w+/).size.should <= 30 
      end

      it "should return the first 30 words and only one full sentance" do
        full_text = %Q(This is some blog content.  There can be tons of text, 
                       following the initial text, but only a certain amount 
                       should be included in the snippet on the web and here are a few more. At what 
                       point should it stop, should it say be as verbose as 
                       I am being now, or should it split at some point?)

        @post = Factory.create(:post, :blog => full_text)
        @post.abstract.should_not == full_text
        @post.abstract.scan(/\./).size.should == 1
        @post.abstract.scan(/\w+/).size.should <= 30
      end

      it "should return the full content of the post" do
        full_text = "Here is some text, but not enough to be a concern." 
        @post = Factory.create(:post, :blog => full_text)
        @post.abstract.should == full_text
      end

      it "should not fail even with only one word" do
        @post = Factory.create(:post, :blog => "Hi")
        @post.abstract.should == "Hi"
      end
    end

    describe "content methods" do
      @post = Factory.create(:post, :title => "A title", :blog => "The content")
      @post.full_post.should == "# A title\n\nThe content"
    end
  end
end
