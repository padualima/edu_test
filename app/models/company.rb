class Company < ApplicationRecord
  has_many :expenses, class_name: 'ParliamentaryExpense'
end
