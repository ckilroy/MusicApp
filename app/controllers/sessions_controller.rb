class SessionsController < ApplicationController

def new
  render :new
end

def create
  user = User.find_by_credentials(params[:user][:email], params[:user][:password])

  if user.nil?
    render :new
  else
    log_in!(user)
    redirect_to user_url(user)
  end
end

def destroy
  user = current_user

  log_out!
  render :new
end
  #description:
  #user gets a user.session_token when they are created. then, when they log in to a
  #sesion, the sesion will set the session[:token] to the user.session_token
  #when they log out the session[:token] is deleted and the user.session_token is reset

end
