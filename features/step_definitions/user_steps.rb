Given /^there are the following users:$/ do |table|
  table.hashes.each do |attr|
    unconfirmed = attr.delete("unconfirmed")
    @user = User.create!(
      attr.merge!(:password_confirmation => attr[:password])
    )
    @user.confirm! unless unconfirmed
  end
end
