class UsersController < ApplicationController
  def new
    @user = User.new
    @message = ''
  end

  def create
    @user = User.new(user_params)
    puts "USERRRR: #{@user}"
    if @user.save!
      redirect_to root_path, notice: "Successfully registered!"
    end

    puts "User did not save"
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
