class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      render :show
    else
      render :new
    end

  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  #description:
  #user gets a user.session_token when they are created. then, when they log in to a
  #sesion, the sesion will set the session[:token] to the user.session_token
  #when they log out the session[:token] is deleted and the user.session_token is reset

end
