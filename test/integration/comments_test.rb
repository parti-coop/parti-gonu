require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test "add comment" do
    log_in_as(:dali)

    previous_version = stands(:stand1).current_version
    assert_equal versions(:stand1_v1), previous_version

    post_version(stands(:stand1), stands(:stand1).choice, 'test')

    assert_equal 'test', assigns(:comment).body

    stands(:stand1).reload
    assert_equal previous_version, fetch_current_version
    assert_includes fetch_current_version().reload.comments, assigns(:comment).reload

    refute_equal stands(:stand1).choice, 'block'

    post_version(stands(:stand1), 'block', 'test')

    assert_equal 'test', assigns(:comment).body

    stands(:stand1).reload
    refute_equal previous_version, fetch_current_version
    assert_includes fetch_current_version().reload.comments, assigns(:comment).reload
  end

  test "new comment of new stand" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))

    post_stand posters(:abc), :in_favor, nil
    stand = posters(:abc).stand_of(users(:dali))
    assert_equal 1, stand.current_version.comments.count
  end


  def fetch_current_version
    stands(:stand1).current_version
  end
end
