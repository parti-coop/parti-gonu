require 'test_helper'

class PostersTest < ActionDispatch::IntegrationTest
  test "new poster" do
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
    log_in_as(:dali)

    post posters_path(poster: { url: 'http://ogp.me'})
    assert_equal 'Open Graph protocol', assigns(:poster).title
    assert_equal 'The Open Graph protocol enables any web page to become a rich object in a social graph.',
                 assigns(:poster).description
  end

  test "related poster" do
    log_in_as(:dali)

    post posters_path(poster: { url: 'http://www.google.co.kr/', relatings_attributes: { '0': { relating_id: posters(:abc) }}})
    assert_includes assigns(:poster).relatable_posters, posters(:abc)
    relating_poster = assigns(:poster).relatable_posters[0]
    assert_includes relating_poster.relatable_posters, assigns(:poster)
  end
end
