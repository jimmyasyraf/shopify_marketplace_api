require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "can show current cart" do
    cart = carts(:grocery)

    get api_v1_cart_path(cart)

    response_json = JSON.parse(response.body)

    assert_equal response_json['cart_items'].length, 1
  end
end
