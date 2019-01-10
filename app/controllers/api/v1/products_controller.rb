class Api::V1::ProductsController < ApplicationController
  swagger_controller :products, "Products"

  swagger_api :index do
    summary "Fetches all Products"
    notes "This lists all products that are in stock"
    response :success
  end

  swagger_api :show do
    summary "Fetches a single Product"
    param :path, :id, :integer, :required, "Product Id"
    response :success
  end

  swagger_api :create do
    summary "Creates a new Product"
    param :form, :title, :string, :required, "Title"
    param :form, :price, :float, :required, "Price"
    param :form, :inventory_count, :integer, :required, "Inventory count"
    response :success
    response :unprocessable_entity
  end

  swagger_api :restock do
    summary "Restock Product inventory"
    param :path, :id, :integer, :required, "Product id"
    param :form, :amount, :integer, :required, "Amount"
    response :success
    response :unprocessable_entity
  end


  def index
    @products = Product.where('inventory_count > 0')

    render json: @products
  end

  def create
    @product = Product.new(title: params[:title], price: params[:price], inventory_count: params[:inventory_count])

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
