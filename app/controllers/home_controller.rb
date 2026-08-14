class HomeController < ApplicationController
  def welcome
    # Redirect to dashboard if user is already signed in
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
end
