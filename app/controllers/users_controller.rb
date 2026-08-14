class UsersController < ApplicationController
  def new
    @user = User.new
    @message = ''
  end

  def create
    # Validate server name first
    server_name = params.dig(:user, :server_name).to_s.strip
    if server_name != ENV['SIGNUP_TOKEN'].to_s
      @user = User.new
      @message = "unknown server"
      render :new
      return
    end

    @user = User.new(user_params)
    if @user.save!
      reset_session
      session[:current_user_id] = @user.id
      redirect_to root_path, notice: "Successfully registered!"
    end
  rescue ActiveRecord::RecordInvalid => invalid
    @message = invalid.record.errors.full_messages.join(", ")
    render :new
  rescue ActiveRecord::RecordNotUnique
    @message = "username already taken"
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
