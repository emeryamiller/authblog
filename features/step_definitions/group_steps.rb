Given /^there are the following groups:$/ do |table|
  table.hashes.each do |attr|
    @users = User.find_by_email(attr.delete("members").split(/,\s?/))
    @group = Group.create!(attr)
    @group.users << @users
    @group.save!
  end
end

