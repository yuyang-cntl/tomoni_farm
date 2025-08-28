require "test_helper"

class Farmer::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get farmer_customers_index_url
    assert_response :success
  end

  test "should get show" do
    get farmer_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get farmer_customers_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmer_customers_update_url
    assert_response :success
  end
end
