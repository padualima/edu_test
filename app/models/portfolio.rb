class Portfolio < ApplicationRecord
  belongs_to :node_group
  belongs_to :member
  has_many :expenses
  has_many :expense_categories, through: :expenses

  monetize :expenses_amount_cents, allow_nil: true, numericality: true
end
