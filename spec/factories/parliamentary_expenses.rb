FactoryBot.define do
  factory :parliamentary_expense do
    ide_document { "MyString" }
    portfolio factory: :portfolio
    company factory: :company
    subquota_number { Faker::Number.number(digits: 2) }
    subquota_specification_number { Faker::Number.number(digits: 0) }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4).upcase }
    exact_description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: true).upcase }
    document_type { Faker::Number.number(digits: 2).to_s }
    value_cents { Random.rand(999999) }
    refund_value_cents { Random.rand(0..999999) }
    refund_number { Faker::Number.number(digits: 1).to_s }
    lot_number { Faker::Number.number(digits: 8).to_s }
    reference_month { '%02d' % Random.rand(0..12) }
    reference_year { rand((Time.current - 10.year)..Time.current).year.to_s }
    issue_at { rand((Time.current - 10.year)..Time.current).to_date.to_s }
  end
end
