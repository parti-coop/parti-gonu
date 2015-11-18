class Poster < ActiveRecord::Base
  belongs_to :user
  has_many :stands
  has_many :versions, through: :stands
  has_many :comments, through: :versions

  default_scope { order(created_at: :desc) }

  before_create :setup_meta

  def has_stand_of?(user)
    stands.exists?(user: user)
  end

  def stand_of(user)
    stands.find_by(user: user)
  end

  private

  def setup_meta
    og = LinkThumbnailer.generate(self.url)
    self.title = og.title
    self.description = og.description
  end
end
