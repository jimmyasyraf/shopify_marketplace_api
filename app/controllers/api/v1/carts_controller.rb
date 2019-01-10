class Api::V1::CartsController < ApplicationController
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
