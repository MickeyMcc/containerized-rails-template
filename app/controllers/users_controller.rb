class UsersController < ApplicationController
  def new
    @user = User.new
    @message = ''
  end

  def create
    # Validate server name first
    server_name = params[:user][:server_name].to_s.strip
    if server_name != ENV['SIGNUP_TOKEN'].to_s
      @user = User.new
      @message = "unknown server"

      puts "RECEIVED SERVER NAME: #{server_name}"
      puts "SERVER NAME ENV: #{ENV['SIGNUP_TOKEN'].to_s}"
      render :new
      return
    end

    @user = User.new(user_params)
    if @user.save!
      redirect_to root_path, notice: "Successfully registered!"
    end
  rescue ActiveRecord::RecordInvalid => invalid
    @message = invalid.record.errors.messages.to_s
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
