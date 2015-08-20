class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?
  # helper_method :log_in!(user)

  def log_in!(user)
    session[:token] = user.reset_session_token!
    #gives user a new session_token
    #sets the session[:token] to that user's new session_token
  end

  def log_out!
    current_user.reset_session_token!
    session[:token] = nil
    #gives the user a new saved session_token
    #sets the session[:token] to nil (no one's logged in)
  end

  def logged_in?
    !!current_user #return the boolean value
  end

  def current_user
    return nil if session[:token].nil?
    #if there's no session[:token], no user is logged in
    @current_user ||= User.find_by_session_token(session[:token])
    #return the current user or set the current user to the user whose
    #user.session_token equals the value of the current session[:token]
    #(we know there is a session[:token] bc we already checked if it was nil)
  end

  #description:
  #user gets a user.session_token when they are created. then, when they log in to a
  #sesion, the session will create new user.session_token and set the session[:token] to the user.session_token
  #when they log out the session[:token] is deleted and the user.session_token is reset



end
