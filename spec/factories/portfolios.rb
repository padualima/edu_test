FactoryBot.define do
  factory :portfolio do
    node_group factory: :node_group
    member factory: :member
    uf { Faker::Address.state_abbr }
    parliamentary_number { Faker::Number.number(digits: 3).to_s }
    legislature { Faker::Number.number(digits: 4).to_s }
    legislature_code { Faker::Number.number(digits: 2).to_s }
    political_party { Faker::Name.initials(number: 2) }
  end
end
