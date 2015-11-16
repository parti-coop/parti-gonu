module Choicable
  extend ActiveSupport::Concern
  included do
    enum choice: { actively_support: 1, in_favor: 2, oppose: 3, block: 4 }
  end
end
