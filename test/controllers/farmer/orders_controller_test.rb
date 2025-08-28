require "test_helper"

class Farmer::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get farmer_orders_show_url
    assert_response :success
  end

  test "should get update" do
    get farmer_orders_update_url
    assert_response :success
  end
end
