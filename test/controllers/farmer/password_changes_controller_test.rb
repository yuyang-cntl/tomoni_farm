require "test_helper"

class Farmer::PasswordChangesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get farmer_password_changes_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmer_password_changes_update_url
    assert_response :success
  end
end
