require "test_helper"

class Farmer::PostImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get farmer_post_images_new_url
    assert_response :success
  end

  test "should get index" do
    get farmer_post_images_index_url
    assert_response :success
  end

  test "should get show" do
    get farmer_post_images_show_url
    assert_response :success
  end
end
