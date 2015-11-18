require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test "new comment" do
    log_in_as(:dali)

    post stand_comments_path(stand_id: stands(:stand1), comment: { body: 'test' })
    assert_equal 'test', assigns(:comment).body
    assert_equal users(:dali), assigns(:comment).user
  end
end
