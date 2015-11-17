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

  def cache_all_stands_count
    Version.choices.keys do |choice|
      update_stand_count(choice, stands.by_choice(choice).count)
    end
  end

  def fetch_stand_count(choice)
    self.read_attribute(stand_count_field(choice))
  end

  def update_stand_count(choice, count)
    self.update(stand_count_field(choice) => count)
  end

  private

  def stand_count_field(choice)
    "stand_#{choice}_count"
  end

  def setup_meta
    og = LinkThumbnailer.generate(self.url)
    self.title = og.title
    self.description = og.description
  end
end
