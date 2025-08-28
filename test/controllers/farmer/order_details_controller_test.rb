require "test_helper"

class Farmer::OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get farmer_order_details_update_url
    assert_response :success
  end
end
