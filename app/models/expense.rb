class Expense < ApplicationRecord
  paginates_per 1

  belongs_to :portfolio
  belongs_to :expense_category
  has_many :expense_companies

  monetize :amount_cents, allow_nil: true, numericality: true
end
