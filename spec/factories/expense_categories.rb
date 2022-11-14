FactoryBot.define do
  factory :expense_category do
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true).upcase }
  end
end
