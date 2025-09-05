require "test_helper"

class Farmer::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get farmer_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmer_profiles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get farmer_profiles_destroy_url
    assert_response :success
  end
end
