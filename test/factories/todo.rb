FactoryBot.define do
  factory :todo do
    sequence(:id) { |n| n }
    title { Faker::Lorem.sentence }
    done { false }
    deleted_at { nil }
    note
  end
end
