class ParliamentaryExpense < ApplicationRecord
  belongs_to :portfolio
  belongs_to :company

  monetize %i[value_cents refund_value_cents],
    allow_nil: true,
    numericality: {
      greater_than_or_equal_to: 0
    }
end
