class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
  	@current_user || User.find(session[:user_id])
  end
end
