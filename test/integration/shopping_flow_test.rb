require 'test_helper'

class ShoppingFlowTest < ActionDispatch::IntegrationTest
  test "shopping flow" do
    banana = products(:banana)
    apple = products(:apple)

    assert_difference "Cart.count", 1 do
      assert_difference "CartItem.count", 1 do
        post api_v1_cart_items_path, params: { product_id: banana.id, quantity: 2}
      end
    end

    cart = Cart.last

    assert_difference "CartItem.count", 1 do
      post api_v1_cart_items_path, params: { product_id: apple.id, cart_id: cart.id, quantity: 2}
    end

    assert_equal banana.inventory_count, 10
    assert_equal apple.inventory_count, 20

    post checkout_api_v1_cart_path(cart)

    banana.reload
    apple.reload
    assert_equal banana.inventory_count, 8
    assert_equal apple.inventory_count, 18

    cart.reload
    assert_equal cart.status, 'checked_out'
  end
end