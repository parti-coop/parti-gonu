ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user_key)
    post new_user_session_path, user: { email: users(user_key).email, password: '87654321' }
    follow_redirect!
  end

  def css_selector(model)
    "##{ActionView::RecordIdentifier::dom_id(model)}"
  end
end
