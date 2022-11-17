class ExpenseCompany < ApplicationRecord
  belongs_to :expense
  belongs_to :company

  monetize :value_cents, allow_nil: true, numericality: true

  def issue_at_formatted
    issued_at&.strftime("%d/%m/%Y")
  end
end
