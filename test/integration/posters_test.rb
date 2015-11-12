require 'test_helper'

class PostersTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "new poster" do
    log_in_as(:dali)

    get new_poster_path
    assert_response :success

    post posters_path(poster: { url: 'http://daum.net' })
    assert_equal users(:dali), assigns(:poster).user
    assert_redirected_to poster_path(assigns(:poster))
  end
end
