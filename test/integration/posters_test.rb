require 'test_helper'

class PostersTest < ActionDispatch::IntegrationTest
  test "new poster" do
    skip

    log_in_as(:dali)

    get new_poster_path
    assert_response :success

    post posters_path(poster: { url: 'http://ogp.me' })
    assert_equal users(:dali), assigns(:poster).user
    assert_redirected_to poster_path(assigns(:poster))
  end

  test "anonymous" do
    get poster_path(posters(:abc), auth: 1)
    assert_redirected_to new_user_session_path
  end

  test "meta attributes" do
    skip

    log_in_as(:dali)

    post posters_path(poster: { url: 'http://ogp.me'})
    assert_equal 'Open Graph protocol', assigns(:poster).title
    assert_equal 'The Open Graph protocol enables any web page to become a rich object in a social graph.',
                 assigns(:poster).description
  end
end
