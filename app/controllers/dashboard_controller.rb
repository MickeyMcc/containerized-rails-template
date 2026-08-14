class DashboardController < ApplicationController
  before_action :authenticated_only


  def index
    @unfound_items = LostAndFoundItem.unfound
    @user_items = current_user.reported_lost_and_found_items
  end

  private

  def authenticated_only
    unless user_signed_in?
      redirect_to "/"
    end
  end
end
