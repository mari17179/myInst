FactoryBot.define do
  factory :like do
    association :user
    association :post
    created_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    updated_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
  end
end
