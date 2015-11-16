class Version < ActiveRecord::Base
  include Choicable

  belongs_to :stand
  belongs_to :previous, class_name: Version
  delegate :poster, to: :stand
  has_many :comments
  accepts_nested_attributes_for :comments

  validate :choice_check

  after_create :update_poster_and_stand
  after_create :update_stand

  def choice_check
    if !previous.nil? and previous.choice == self.choice
      errors.add(:choice, "이전 입장과 달라야")
    end
  end

  def user
    stand.user
  end

  def is_first?
    previous.nil?
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
