class Relatable < ActiveRecord::Base
  belongs_to :relating, class_name: Poster
  belongs_to :related, class_name: Poster
end
