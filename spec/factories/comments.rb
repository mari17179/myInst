FactoryBot.define do
  factory :comment do
    association :user
    association :post
    comment { Faker::Movies::HarryPotter.spell }
    created_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    updated_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
  end
end
