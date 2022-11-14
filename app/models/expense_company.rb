class ExpenseCompany < ApplicationRecord
  belongs_to :expense
  belongs_to :company
end
