require "test_helper"

class Admin::PostersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_posters_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_posters_show_url
    assert_response :success
  end
end
