FactoryBot.define do
  factory :company do
    name { Faker::Company.industry }
    document { Faker::CNPJ.numeric }
  end
end
