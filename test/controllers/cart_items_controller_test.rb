require 'test_helper'

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "can add items to new cart" do
    product = products(:banana)

    assert_difference "Cart.count", 1 do
      assert_difference "CartItem.count", 1 do
      post api_v1_cart_items_path, params: { product_id: product.id, quantity: 2}
      end
    end
  end

  test "can add items to existing cart" do
    product = products(:banana)
    cart = carts(:grocery)

    assert_equal cart.cart_items.count, 1

    assert_difference "Cart.count", 0 do
      assert_difference "CartItem.count", 1 do
      post api_v1_cart_items_path, params: { product_id: product.id, cart_id: cart.id, quantity: 2}
      end
    end

    cart.reload
    assert_equal cart.cart_items.count, 2
  end

  test "can add more item quantity to existing cart" do
    cart = carts(:grocery)
    cart_item = cart_items(:apple_in_cart)

    assert_equal cart_item.quantity, 2

    put api_v1_cart_item_path(cart_item), params: { cart_id: cart.id, quantity: 3}

    cart_item.reload
    assert_equal cart_item.quantity, 3
  end

  test "can delete item in cart" do
    cart = carts(:grocery)
    cart_item = cart_items(:apple_in_cart)

    assert_equal cart.cart_items.count, 1

    delete api_v1_cart_item_path(cart_item), params: { cart_id: cart.id}

    cart.reload
    assert_equal cart.cart_items.count, 0
  end
end
