require 'test_helper'

class StandsTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "first stands" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))
    assert posters(:abc).stands.any?

    get poster_path(posters(:abc))
    assert_select css_selector(posters(:abc).stands[0]), false

    post_stand :in_favor
    assert_equal posters(:abc), assigns(:stand).reload.poster
    assert_equal 'in_favor', assigns(:stand).reload.current_version.choice

    assert_equal true, posters(:abc).has_stand_of?(users(:dali))

    get poster_path(posters(:abc))
    assert_select css_selector(posters(:abc).stands[0])

    stand = fetch_stand
    assert_equal 'in_favor', stand.current_version.choice
  end

  test "stands versions" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))

    post_stand :in_favor
    stand1 = fetch_stand
    assert_equal 1, stand1.versions.count

    post_version stand1, :block
    stand2 = fetch_stand
    assert_equal stand1.id, stand2.id
    assert_equal 2, stand2.versions.count
    assert_equal stand2.versions[0], assigns(:version).previous

    post_version stand1, :in_favor
    assert_equal 3, fetch_stand.versions.count

    post_version stand1, :in_favor
    refute_nil flash[:error]
  end

  def fetch_stand
    posters(:abc).stand_of(users(:dali))
  end

  def post_stand(choice)
    post poster_stands_path(poster_id: posters(:abc), stand: {versions_attributes: [{choice: choice.to_s, comment: 'test'}]})
  end

  def post_version(stand, choice)
    post stand_versions_path(stand_id: stand, version: {choice: choice.to_s, comment: 'test'})
  end
end
