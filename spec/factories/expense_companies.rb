FactoryBot.define do
  factory :expense_company do
    expense  factory: :expense
    company factory: :company
    ide_document { Faker::Number.number(digits: 7).to_s }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4).upcase }
    exact_description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true).upcase }
    value_cents { Random.rand(999999) }
    issued_at { rand((Time.current - 10.year)..Time.current).to_date.to_s }
  end
end
