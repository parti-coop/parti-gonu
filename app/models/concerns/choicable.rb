module Choicable
  extend ActiveSupport::Concern
  included do
    enum choice: { in_favor: 1, oppose: 2, abstain: 3 }
  end
end
