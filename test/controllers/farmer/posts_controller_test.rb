require "test_helper"

class Farmer::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get farmer_posts_new_url
    assert_response :success
  end

  test "should get index" do
    get farmer_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get farmer_posts_show_url
    assert_response :success
  end

  test "should get create" do
    get farmer_posts_create_url
    assert_response :success
  end

  test "should get edit" do
    get farmer_posts_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmer_posts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get farmer_posts_destroy_url
    assert_response :success
  end
end
