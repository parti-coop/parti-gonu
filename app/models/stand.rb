class Stand < ActiveRecord::Base
  belongs_to :user
  belongs_to :poster
  has_many :versions
  accepts_nested_attributes_for :versions

  def current_version
    versions.last
  end
end
