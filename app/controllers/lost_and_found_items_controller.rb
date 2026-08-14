class LostAndFoundItemsController < ApplicationController
  before_action :authenticated_only
  before_action :set_item, only: [:show, :edit, :update, :mark_found]

  def index
    @items = LostAndFoundItem.unfound
  end

  def show
  end

  def new
    @item = current_user.reported_lost_and_found_items.build
  end

  def create
    @item = current_user.reported_lost_and_found_items.build(item_params)

    if @item.save
      redirect_to @item, notice: "Lost and found item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_owner!
  end

  def update
    authorize_owner!

    if @item.update(item_params)
      redirect_to @item, notice: "Lost and found item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def mark_found
    @item.update(status: "found", found_by_user_id: current_user.id)
    redirect_to @item, notice: "Item marked as found!"
  end

  private

  def set_item
    @item = LostAndFoundItem.find(params[:id])
  end

  def item_params
    params.require(:lost_and_found_item).permit(:title, :description, :location)
  end

  def authorize_owner!
    redirect_to root_path, alert: "Not authorized" unless @item.reported_by_user_id == current_user.id
  end

  def authenticated_only
    unless user_signed_in?
      redirect_to "/"
    end
  end
end
