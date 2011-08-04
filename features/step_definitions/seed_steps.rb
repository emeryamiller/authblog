Given /^there is a post called "([^"]*)"$/ do |title|
  Factory(:post, :title => title, :draft => false)
end

Given /^there is a draft post called "([^"]*)"$/ do |title|
  Factory(:post, :title => title, :draft => true)
end

Given /^there are the following posts:$/ do |table|
  table.hashes.each do |attr|
    group_names = attr.delete("group").split(/,\s?/)
    draft = Boolean(attr.delete("draft"))
    @post = Post.create!(attr.merge!(blog:"Sample text"))
    @post.draft = draft
    unless group_names == []
      groups = Group.find_all_by_name(group_names)
      @post.groups << groups
    end
    @post.save!
  end
end
