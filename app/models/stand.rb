class Stand < ActiveRecord::Base
  include Choicable

  belongs_to :user
  belongs_to :poster
  has_many :versions
  accepts_nested_attributes_for :versions

  scope :by_choice, -> (choice) { where(choice: choice) }

  def current_version
    versions.last
  end

  def assure_first_comment
    current_version.comments.build if current_version.comments.empty?
  end
end
