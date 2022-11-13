FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    cpf { Faker::CPF.number }
    ide { Faker::Number.number(digits: 6).to_s }
  end
end
