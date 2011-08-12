require 'spec_helper'

describe "Boolean" do
  it "should convert string's with true in it to boolean true" do
    Boolean('true').should == true
    Boolean('is true').should == true
    Boolean('false').should == false
    Boolean('un uh').should == false
  end

  it "should pass boolean values back as is" do
    Boolean(true).should == true
    Boolean(false).should == false
  end

  it "should pass objects back as is" do
    Boolean(User.first).should == User.first
  end
end
