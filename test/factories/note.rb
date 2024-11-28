FactoryBot.define do
  factory :note do
    sequence(:id) { |n| n }
    title { Faker::Lorem.sentence }
    deleted_at { nil }
  end
end
