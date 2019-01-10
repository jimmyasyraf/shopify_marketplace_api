require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "can show current cart" do
    cart = carts(:grocery)

    get api_v1_cart_path(cart)

    response_json = JSON.parse(response.body)

    assert_equal response_json['cart_items'].length, 1
  end

  test "can checkout cart" do
    cart = carts(:grocery)
    product = products(:apple)

    assert_equal product.inventory_count, 20

    post checkout_api_v1_cart_path(cart)

    product.reload
    assert_equal product.inventory_count, 18

    cart.reload
    assert_equal cart.status, 'checked_out'
  end
end
