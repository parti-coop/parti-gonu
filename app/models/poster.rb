class Poster < ActiveRecord::Base
  belongs_to :user
  belongs_to :source
  has_many :stands
  has_many :versions, through: :stands
  has_many :comments, through: :versions
  has_many :relatings, class_name: Relatable, foreign_key: :related_id
  has_many :relateds, class_name: Relatable, foreign_key: :relating_id
  has_many :relating_posters, through: :relatings, source: :relating
  has_many :related_posters, through: :relateds, source: :related

  accepts_nested_attributes_for :relatings

  default_scope { order(created_at: :desc) }

  def has_stand_of?(user)
    stands.exists?(user: user)
  end

  def stand_of(user)
    stands.find_by(user: user)
  end

  def relatable_posters
    (relating_posters.all + related_posters.all).uniq
  end

  def url
    self_or_source(:url)
  end

  def title
    self_or_source(:title)
  end

  def description
    self_or_source(:description)
  end

  def image
    self_or_source(:image)
  end

  def same_sourced_posters
    source.posters.where.not(id: self)
  end

  private

  def self_or_source(field)
    read_attribute(field) || source.try(field)
  end
end
