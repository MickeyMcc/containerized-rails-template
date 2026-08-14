class DashboardController < ApplicationController
  before_action :authenticated_only


  def index
  end

  private

  def authenticated_only
    unless user_signed_in?
      redirect_to "/"
    end
  end
end
