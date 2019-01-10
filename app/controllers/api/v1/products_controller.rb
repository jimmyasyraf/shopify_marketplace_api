module Api
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.where('inventory_count > 0')

        render json: @products
      end

      def create
        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def show
        @product = Product.find(params[:id])
        render json: @product
      end

      def restock
        @product = Product.find(params[:id])
        additional_amount = params[:amount].to_i
        @product.inventory_count = @product.inventory_count + additional_amount
        
        if @product.save
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:product).permit(:title, :price, :inventory_count)
      end

      def products_serialized(products = @products)
        products_list = []
        products.each do |product|
          products_list << product_serialized(product)
        end
        products_list
      end

      def product_serialized(product=@product)
        {
          id: product.id,
          title: product.title,
          price: product.price,
          inventory_count: product.inventory_count
        }
      end
    end
  end
end
