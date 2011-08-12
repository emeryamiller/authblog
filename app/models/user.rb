class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,  :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, 
  :recoverable, :rememberable, :confirmable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  belongs_to :group
  has_many :authentications

  scope :admin, where(admin:true)

  def admin?
    admin
  end

  #Omniauth methods

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.find_for_openid_oauth(access_token, signed_in_resource=nil)
    authentication = Authentication.find_or_create_by_uid_and_provider(access_token["uid"], access_token["provider"].downcase)
    puts OmniAuth.config.mock_auth.inspect
    puts access_token.inspect
    puts authentication.inspect
    if user = signed_in_resource
      user.authentications << authentication
      user.save!
      user
    else
      if user = authentication.user
        user
      else # Create a user with a stub password. 
       user = User.create!(:email => access_token['user_info']["email"], :password => Devise.friendly_token[0,20]) 
       user.authentications << authentication
       user.save!
       user
      end
    end
  end
end
