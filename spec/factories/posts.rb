FactoryBot.define do
  factory :post do
    association :user

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.jpg')) }
    description { Faker::Movies::HarryPotter.quote }
    created_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    updated_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
  end
end
