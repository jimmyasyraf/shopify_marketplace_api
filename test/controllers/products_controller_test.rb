require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "list all products that are available" do
    assert_equal Product.count, 3

    get products_path

    assert_response :success

    response_json = JSON.parse(response.body)

    assert_equal response_json.length, 2
  end

  test "can create a product" do
    assert_difference "Product.count", 1 do
      post products_path, params: { product: { title: "Apple", price: 2.00, inventory_count: 20} }
    end
  end

  test "can restock a product" do
    product = products(:apple)

    assert_equal product.inventory_count, 20
    get restock_product_path(product), params: { amount: 10}

    product.reload
    assert_equal product.inventory_count, 30
  end
end
