class Api::V1::CartItemsController < ApplicationController
  def create
    @cart = current_cart
    @item = @cart.cart_items.new(product_id: params[:product_id], quantity: params[:quantity])

    if @cart.save
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])

    if @cart_item.update_attributes(quantity: params[:quantity])
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    
    if @cart_item.destroy
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def current_cart
    if params[:cart_id].present?
      Cart.find(params[:cart_id])
    else
      Cart.new
    end
  end
end
