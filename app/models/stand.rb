class Stand < ActiveRecord::Base
  include Choicable

  belongs_to :user
  belongs_to :poster
  has_many :versions
  has_many :comments do
    def persisted
      collect{ |comment| comment if comment.persisted? }
    end
  end

  accepts_nested_attributes_for :versions

  scope :latest, ->{ order(updated_at: :desc) }
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

  def statuses
    result = comments.persisted + versions
    result.compact.sort_by!(&:created_at).reverse
  end
end
