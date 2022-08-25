require "test_helper"

class Public::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_addresses_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_addresses_edit_url
    assert_response :success
  end
end
