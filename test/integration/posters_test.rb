require 'test_helper'

class PostersTest < ActionDispatch::IntegrationTest
  test "new poster" do
    log_in_as(:dali)

    get new_poster_path
    assert_response :success

    post posters_path(poster: { url: 'http://ogp.me', question: 'question1' })
    assert_equal users(:dali), assigns(:poster).user
    assert_equal 'question1', assigns(:poster).question
    assert_redirected_to poster_path(assigns(:poster))
  end

  test "anonymous" do
    get poster_path(posters(:abc), auth: 1)
    assert_redirected_to new_user_session_path
  end

  test "meta attributes" do
    log_in_as(:dali)

    post posters_path(poster: { url: 'http://ogp.me', question: 'question1' })
    assert_equal 'http://ogp.me', assigns(:poster).source.url
    assert_equal 'Open Graph protocol', assigns(:poster).source.title
    assert_equal 'The Open Graph protocol enables any web page to become a rich object in a social graph.',
                 assigns(:poster).source.description
  end

  test "related poster" do
    log_in_as(:dali)

    post posters_path(poster: { url: 'http://www.google.co.kr/', question: 'question1', relatings_attributes: { '0': { relating_id: posters(:abc) }}})
    assert_includes assigns(:poster).relatable_posters, posters(:abc)
    relating_poster = assigns(:poster).relatable_posters[0]
    assert_includes relating_poster.relatable_posters, assigns(:poster)
  end

  test "same url" do
    log_in_as(:dali)

    post posters_path(poster: { url: 'http://www.google.co.kr/', question: 'question1'})
    source = assigns(:poster).source
    post posters_path(poster: { url: 'http://www.google.co.kr/', question: 'question2'})
    assert_equal source, assigns(:poster).source
    assert_includes assigns(:poster).source.posters, assigns(:poster)
  end
end
