def create_user(raw_options)
  options = HashWithIndifferentAccess.new(raw_options)
  options[:password] ||= 'password'
  options[:password_confirmation] = options[:password]
  admin = Boolean(options.delete(:admin))
  unconfirmed = Boolean(options.delete(:unconfirmed))
  authorized = Boolean(options.delete(:authorized))
  provider = options.delete(:provider)
  provider.downcase! if provider
  
  user = User.create!(options)
  user.admin = true if admin
  user.confirm! unless unconfirmed
  #user.authorize! if authorized
  unless provider.blank?
    user.authentications << Authentication.create!(provider:provider, uid:"auniqueid_#{options[:email]}") 
    add_oa_mock(provider, options[:email]) 
  end
  user.save!

  user
end

