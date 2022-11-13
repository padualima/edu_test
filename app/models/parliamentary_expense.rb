class ParliamentaryExpense < ApplicationRecord
  belongs_to :portfolio
  belongs_to :company
end
