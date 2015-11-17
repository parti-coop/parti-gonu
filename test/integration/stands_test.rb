require 'test_helper'

class StandsTest < ActionDispatch::IntegrationTest
  test "first stands" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))
    assert posters(:abc).stands.any?

    get poster_path(posters(:abc))
    assert_select css_selector(posters(:abc).comments[0]), false

    post_stand posters(:abc), :in_favor, 'test'
    assert_equal posters(:abc), assigns(:stand).reload.poster
    assert_equal 'in_favor', assigns(:stand).reload.current_version.choice

    assert_equal true, posters(:abc).has_stand_of?(users(:dali))

    get poster_path(posters(:abc))
    assert_select css_selector(posters(:abc).comments[0])

    stand = fetch_stand
    assert_equal 'in_favor', stand.current_version.choice
  end

  test "stands versions" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))

    post_stand posters(:abc), :in_favor, 'test'
    stand1 = fetch_stand
    assert_equal 1, stand1.versions.count

    post_version stand1, :oppose, 'test'
    stand2 = fetch_stand
    assert_equal stand1.id, stand2.id
    assert_equal 2, stand2.versions.count
    assert_equal stand2.versions[0], assigns(:version).previous

    post_version stand1, :in_favor, 'test'
    assert_equal 3, fetch_stand.versions.count

    post_version stand1, :in_favor, 'test'
    assert_equal 3, fetch_stand.versions.count
  end

  test "stands count" do
    log_in_as(:dali)

    refute posters(:abc).has_stand_of?(users(:dali))

    first_count = posters(:abc).fetch_stand_count(:in_favor)

    post_stand posters(:abc), :in_favor, 'test'
    assert_equal first_count + 1, posters(:abc).reload.stands.count
  end

  def fetch_stand
    posters(:abc).stand_of(users(:dali))
  end
end
