require "test_helper"

class Public::PostersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_posters_index_url
    assert_response :success
  end

  test "should get show" do
    get public_posters_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_posters_edit_url
    assert_response :success
  end
end
