class AuthenticationsController < ApplicationController
  before_filter :omniauth_redirects_to_accounts, only:[:edit, :index]
  before_filter :omniauth_redirects_normally, only:[:new]
  before_filter :services

  def index
    @email = current_user.email if current_user
    @authentications = current_user.authentications if current_user
    @authentications ||= []
  end

  def new
  end

  def edit
  end

  def show
  end

  private

  def omniauth_redirects_to_accounts
    session[:omniauth_add_service] = true
  end

  def omniauth_redirects_normally
    session[:omniauth_add_service] = nil
  end

  def services
    #TODO - must be a way to get configured services from devise
    @services = [:google, :yahoo]
  end
end
