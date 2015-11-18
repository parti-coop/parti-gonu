module Choicable
  extend ActiveSupport::Concern
  included do
    enum choice: { in_favor: 1, oppose: 2, abstain: 3 }
    scope :by_choice, -> (choice) { send(choice) }
  end
end
