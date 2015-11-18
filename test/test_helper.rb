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

  def post_version(stand, choice, comment_body)
    versions_attributes = make_versions_attributes choice, comment_body
    versions_attributes[:comments_attributes] = {'0': {body: comment_body}} if comment_body.present?
    post stand_versions_path(stand_id: stand, version: versions_attributes)
  end

  def patch_stand(stand, choice, reason)
    versions_attributes = make_versions_attributes choice, reason
    patch stand_path(id: stand, stand: {versions_attributes: {'0': versions_attributes}})
  end

  def post_stands(poster, choice, reason)
    versions_attributes = make_versions_attributes choice, reason
    post poster_stands_path(poster_id: poster, stand: {versions_attributes: {'0': versions_attributes}})
  end

  def make_versions_attributes(choice, reason)
    {choice: choice.to_s, reason: reason}
  end
end
