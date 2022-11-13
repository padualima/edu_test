FactoryBot.define do
  factory :node_group do
    slug { Faker::Internet.slug }
  end
end
