class SessionsController < ApplicationController
  before_action :check_signed_in, except: :destroy

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(sign_in_params[:username], sign_in_params[:password])

    if user
      log_in!(user)
      redirect_to cats_url
    else
      flash[:errors] = ["Invalid sign-in"]
      render :new
    end
  end

  def destroy
    SessionToken.where(session_token: session[:session_token]).destroy_all
    session[:session_token] = nil
    redirect_to cats_url
  end

  private
  def sign_in_params
    params.require(:user).permit(:username, :password)
  end


end
