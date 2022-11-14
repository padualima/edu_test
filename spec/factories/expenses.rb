FactoryBot.define do
  factory :expense do
    portfolio factory: :portfolio
    expense_category factory: :expense_category
    amount_cents { Random.rand(999999) }
  end
end
