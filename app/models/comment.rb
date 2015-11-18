class Comment < ActiveRecord::Base
  belongs_to :stand
  belongs_to :user
  
  scope :latest, ->{ order(id: :desc) }

  def stand_of_user
    poster.stand_of(user) if has_stand_of_user?
  end

  def has_stand_of_user?
    poster.has_stand_of? user
  end

  def poster
    stand.poster
  end

  def is_first?
    version.comments.first == self
  end
end
