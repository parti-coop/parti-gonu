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
  has_many :supports
  has_many :supporteds, class_name: Support, foreign_key: :target_id do
    def by_user(user)
      joins(:stand).where(stands: {user_id: user})
    end
  end

  accepts_nested_attributes_for :versions

  scope :latest, ->{ order(updated_at: :desc) }

  def current_version
    versions.offset(0).last
  end

  def previous_version
    versions.offset(1).last
  end

  def has_changes?
    versions.count > 1
  end

  def supported?(user)
    supporteds.by_user(user).exists?
  end

  def supported(user)
    supporteds.by_user(user).first
  end

  def reason
    current_version.reason
  end

  def choice
    current_version.choice
  end

  def statuses
    result = comments.persisted + versions + supports + supporteds
    result.compact.sort_by!(&:created_at).reverse
  end
end
