class Version < ActiveRecord::Base
  include Choicable

  belongs_to :stand
  belongs_to :previous, class_name: Version
  delegate :poster, to: :stand

  scope :latest, ->{ order(id: :desc) }

  after_create :update_poster_and_stand
  after_create :update_stand

  def user
    stand.user
  end

  def is_first?
    previous.nil?
  end

  def same? params
    params[:choice] == self.choice and params[:reason] == self.reason
  end

  def change_choice?
    self.previous.present? and self.choice != previous.choice
  end

  def change_reason?
    self.previous.present? and self.reason != previous.reason
  end

  private

  def update_poster_and_stand
    update_stand
    update_poster
  end

  def update_poster
    poster.cache_all_stands_count
    poster.save
  end

  def update_stand
    stand.choice = self.choice
    stand.save
  end
end
