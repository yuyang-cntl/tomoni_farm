require "test_helper"

class Farmer::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get farmer_homes_top_url
    assert_response :success
  end
end
