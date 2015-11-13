class Poster < ActiveRecord::Base
  belongs_to :user
  has_many :stands
  has_many :versions, through: :stands
  has_many :comments, through: :versions

  def has_stand_of?(user)
    stands.exists?(user: user)
  end

  def stand_of(user)
    stands.find_by(user: user)
  end
end
