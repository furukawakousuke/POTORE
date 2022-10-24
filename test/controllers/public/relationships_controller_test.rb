require "test_helper"

class Public::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get public_relationships_follow_url
    assert_response :success
  end

  test "should get follower" do
    get public_relationships_follower_url
    assert_response :success
  end
end
