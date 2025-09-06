require "test_helper"

class Public::PasswordChangesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_password_changes_edit_url
    assert_response :success
  end
end
