FactoryBot.define do
  factory :expense do
    portfolio factory: :portfolio
    amount_cents { Random.rand(999999) }
  end
end
