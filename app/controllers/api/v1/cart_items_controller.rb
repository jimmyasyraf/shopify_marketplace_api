class Api::V1::CartItemsController < ApplicationController
  swagger_controller :products, "Shopping cart items"

  swagger_api :create do
    summary "Add new item to cart"
    param :form, :cart_id, :integer, :optional, "Existing cart id. Leave empty to create a new cart"
    param :form, :product_id, :string, :required, "Product id"
    param :form, :quantity, :integer, :required, "Item quantity"
    response :success
    response :unprocessable_entity
    response :internal_server_error
  end

  swagger_api :update do
    summary "Edit item quantity"
    param :path, :id, :integer, :required, "Item id"
    param :form, :cart_id, :integer, :required, "Existing cart id"
    param :form, :quantity, :integer, :required, "Item quantity"
    response :success
    response :unprocessable_entity
    response :internal_server_error
  end

  swagger_api :destroy do
    summary "Remove item from cart"
    param :path, :id, :integer, :required, "Item id"
    param :form, :cart_id, :integer, :required, "Existing cart id"
    response :success
    response :unprocessable_entity
    response :internal_server_error
  end

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
