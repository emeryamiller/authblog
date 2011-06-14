Given /^there is a post called "([^"]*)"$/ do |title|
  Factory(:post, :title => title)
end
