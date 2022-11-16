class Portfolio < ApplicationRecord
  belongs_to :node_group
  belongs_to :member
  has_many :expenses
  has_many :expense_categories, through: :expenses
  has_many :expense_companies, through: :expenses

  monetize :expenses_amount_cents, allow_nil: true, numericality: true

  validates :uf, :parliamentary_number, :legislature, :legislature_code, :political_party,
            uniqueness: { scope: [:node_group_id, :member_id] }
end
