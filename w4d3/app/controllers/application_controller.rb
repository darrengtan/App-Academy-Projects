

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return @current_user if @current_user
    current_session_token = SessionToken.find_by(session_token: session[:session_token])
    if current_session_token
      @current_user = current_session_token.user
    else
      nil
    end
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!.session_token
  end

  def check_signed_in
    if current_user
      redirect_to cats_url
    end
  end
end
