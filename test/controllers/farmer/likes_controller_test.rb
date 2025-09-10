require "test_helper"

class Farmer::LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get farmer_likes_index_url
    assert_response :success
  end
end
