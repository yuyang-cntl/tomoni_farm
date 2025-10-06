require "test_helper"

class Farmer::BroadcastLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get farmer_broadcast_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get farmer_broadcast_logs_show_url
    assert_response :success
  end
end
