require "test_helper"

class Public::PostPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_post_photos_new_url
    assert_response :success
  end

  test "should get index" do
    get public_post_photos_index_url
    assert_response :success
  end

  test "should get show" do
    get public_post_photos_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_post_photos_edit_url
    assert_response :success
  end
end
