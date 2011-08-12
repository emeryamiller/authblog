class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery except:[:google, :open_id]

  def google
    process_open_id
  end

  def yahoo
    process_open_id
  end

  def open_id
    process_open_id
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def process_open_id
    #puts env["omniauth.auth"]
    adding_service = session[:omniauth_add_service]
    session[:omniauth_add_service] = nil

    service = env["omniauth.auth"]["provider"]
    @user = User.find_for_openid_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => service.to_s.titleize
      if adding_service
        redirect_to authentications_path
      else
        sign_in @user, :event => :authentication
        redirect_to root_path
      end
    else
      session["devise.#{service.to_s}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
end

