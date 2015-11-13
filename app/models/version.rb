class Version < ActiveRecord::Base
  belongs_to :stand
  belongs_to :previous, class_name: Version

  enum choice: { actively_support: 1, in_favor: 2, oppose: 3, block: 4 }

  validate :choice_check

  def choice_check
    if !previous.nil? and previous.choice == self.choice
      errors.add(:choice, "이전 입장과 달라야")
    end
  end
end
