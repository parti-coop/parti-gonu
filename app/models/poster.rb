class Poster < ActiveRecord::Base
  belongs_to :user
  has_many :stands

  def has_stand_of?(user)
    stands.exists?(user: user)
  end

  def stand_of(user)
    stands.find_by(user: user)
  end
end
