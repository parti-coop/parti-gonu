class Comment < ActiveRecord::Base
  belongs_to :version

  scope :latest, ->{ order(id: :desc) }

  def user
    version.user
  end

  def is_first?
    version.comments.first == self
  end
end
