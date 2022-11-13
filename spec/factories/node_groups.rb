FactoryBot.define do
  factory :node_group do
    slug { rand((Time.current - 10.year)..Time.current).year.to_s }
    ancestry { nil }
  end
end
