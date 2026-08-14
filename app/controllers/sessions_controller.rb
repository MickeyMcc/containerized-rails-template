class SessionsController < ApplicationController
  def new
  end

  def create
    username = params.dig(:user, :username).to_s.strip.downcase
    password = params.dig(:user, :password).to_s

    # Validate input presence
    if username.blank? || password.blank?
      flash.now[:alert] = "Username and password are required."
      render :new, status: :unprocessable_entity
      return
    end

    @user = User.find_by(username: username)
    if @user&.authenticate(password)
      reset_session
      session[:current_user_id] = @user.id
      redirect_to "/dashboard", notice: "Signed in."
    else
      flash.now[:alert] = "Incorrect username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
