class Portfolio < ApplicationRecord
  paginates_per 10
  belongs_to :node_group
  belongs_to :member
  has_many :expenses
  has_many :expense_categories, through: :expenses
  has_many :expense_companies, through: :expenses

  monetize :expenses_amount_cents, allow_nil: true, numericality: true

  validates :uf, :parliamentary_number, :legislature, :legislature_code, :political_party,
            uniqueness: { scope: [:node_group_id, :member_id] }

  scope :find_by_group, -> (year_group_id, state_group_id) do
    joins(:node_group)
      .where(
        node_groups: {
          id: state_group_id,
          ancestry: year_group_id,
          kind: NodeGroup.kinds['state']
        }
      )
      .order(expenses_amount_cents: :desc)
  end

  def greater_expense_companies
    expense_companies.order(value_cents: :desc).first
  end

  def expenses_order_by_greater
    expenses.order(amount_cents: :desc).group(:id)
  end
end
