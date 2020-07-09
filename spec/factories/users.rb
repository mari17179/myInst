FactoryBot.define do
  factory :user do
    username { FFaker::Name.unique.name }
    email { FFaker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
