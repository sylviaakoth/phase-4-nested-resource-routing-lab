class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find_by!(id: params[:user_id])
      items = user.items
      return  render json: items
    else
      items = Item.all
      return  render json: items, include: :user
    end
  end

  def create
    item = Item.create!(item_params)
    render json: item, status: :created
  end

  def show
    item = Item.find_by!(id: params[:id])
    render json: item
  end

  private
  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end  
end
