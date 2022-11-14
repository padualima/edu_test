class Expense < ApplicationRecord
  belongs_to :portfolio

  monetize :amount_cents, allow_nil: true, numericality: true
end
