class Api::V1::CartsController < ApplicationController
  swagger_controller :carts, "Shopping cart"

  swagger_api :show do
    summary "Fetches a single Cart"
    param :path, :id, :integer, :required, "Cart Id"
    response :success
  end

  swagger_api :checkout do
    summary "Checkout a Cart"
    param :path, :id, :integer, :required, "Cart Id"
    response :success
  end

  def show
    @cart = Cart.find(params[:id])
    render json: @cart
  end

  def checkout
    @cart = Cart.find(params[:id])
    if @cart.checkout!
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end
end
