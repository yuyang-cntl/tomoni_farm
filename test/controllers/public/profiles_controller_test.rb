require "test_helper"

class Public::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_profiles_update_url
    assert_response :success
  end

  test "should get show" do
    get public_profiles_show_url
    assert_response :success
  end
end
