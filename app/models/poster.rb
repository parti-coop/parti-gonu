class Poster < ActiveRecord::Base
  belongs_to :user
  has_many :stands
  has_many :versions, through: :stands
  has_many :comments, through: :versions
  has_many :relatings, class_name: Relatable, foreign_key: :related_id
  has_many :relateds, class_name: Relatable, foreign_key: :relating_id
  has_many :relating_posters, through: :relatings, source: :relating
  has_many :related_posters, through: :relateds, source: :related

  accepts_nested_attributes_for :relatings

  default_scope { order(created_at: :desc) }

  before_create :setup_meta

  def has_stand_of?(user)
    stands.exists?(user: user)
  end

  def stand_of(user)
    stands.find_by(user: user)
  end

  def relatable_posters
    (relating_posters.all + related_posters.all).uniq
  end

  private

  def setup_meta
    og = LinkThumbnailer.generate(self.url)
    self.title = og.title
    self.description = og.description
  end
end
