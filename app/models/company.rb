class Company < ApplicationRecord
  has_many :expense_companies
  has_many :expenses, through: :expense_companies
end
