require "test_helper"

class Farmer::DiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get farmer_diaries_new_url
    assert_response :success
  end

  test "should get index" do
    get farmer_diaries_index_url
    assert_response :success
  end

  test "should get show" do
    get farmer_diaries_show_url
    assert_response :success
  end

  test "should get edit" do
    get farmer_diaries_edit_url
    assert_response :success
  end
end
