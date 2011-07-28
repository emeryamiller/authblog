Given /^there are the following groups:$/ do |table|
  table.hashes.each do |attr|
    @user = User.find_by_email(attr.delete("member"))
    @group = Group.create!(attr)
    @group.users << @user
    @group.save!
  end
end

