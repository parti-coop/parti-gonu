class Stand < ActiveRecord::Base
  belongs_to :user
  belongs_to :poster
  has_many :versions
  accepts_nested_attributes_for :versions

  def current_version
    versions.last
  end

  def current_choice
    current_version.choice
  end

  def assure_first_comment
    current_version.comments.build if current_version.comments.empty?
  end
end
