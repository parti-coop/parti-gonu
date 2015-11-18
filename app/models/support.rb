class Support < ActiveRecord::Base
  belongs_to :stand
  belongs_to :target, class_name: Stand, foreign_key: :target_id
end
