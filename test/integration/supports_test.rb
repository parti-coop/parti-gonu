require 'test_helper'

class SupportsTest < ActionDispatch::IntegrationTest
  test "support" do
    log_in_as(:rest515)

    assert posters(:abc).has_stand_of?(users(:rest515))
    assert_equal posters(:abc), stands(:stand1).poster
    assert_equal stands(:stand1).user, users(:rest515)

    post supports_path(target_id: stands(:stand2))
    assert_equal stands(:stand1), assigns(:support).stand
    assert_equal stands(:stand2), assigns(:support).target

    delete support_path(assigns(:support))
    refute_includes assigns(:stand).supports, assigns(:support)
  end
end
