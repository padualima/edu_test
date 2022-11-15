FactoryBot.define do
  factory :node_group do
    slug { rand((Time.current - 10.year)..Time.current).year.to_s }
    ancestry { nil }
    kind { NodeGroup.kinds['year'] }

    trait :with_state_type_child_group do
      after(:create) do |group|
        child =
          build(:node_group, slug: NodeGroup.states_allowed.sample, kind: NodeGroup.kinds['state'] )
        child.parent = group
        child.save
      end
    end
  end
end
