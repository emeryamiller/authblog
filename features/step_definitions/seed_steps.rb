Given /^there is a post called "([^"]*)"$/ do |title|
  Factory(:post, :title => title, :draft => false)
end

Given /^there is a draft post called "([^"]*)"$/ do |title|
  Factory(:post, :title => title, :draft => true)
end

Given /^there are the following posts:$/ do |table|
  table.hashes.each do |attr|
    group_name = attr.delete("group")
    draft = Boolean(attr.delete("draft"))
    @post = Post.create!(attr.merge!(blog:"Sample text"))
    @post.draft = draft
    if group_name != ""
      group = Group.find_by_name(group_name)
      @post.groups << group  
    end
    @post.save!
  end
end
