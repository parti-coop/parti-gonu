class Stand < ActiveRecord::Base
  include Choicable

  belongs_to :user
  belongs_to :poster
  has_many :versions
  accepts_nested_attributes_for :versions

  scope :latest, ->{ order(id: :desc) }
  scope :by_choice, -> (choice) { where(choice: choice) }

  def current_version
    versions.last
  end

  def previous_version
    versions.offset(1).last
  end

  def has_changes?
    versions.count > 1
  end

  def reason
    current_version.reason
  end

  def choice
    current_version.choice
  end
end
