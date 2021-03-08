FactoryBot.define do
  factory :user do
    eemail { "MyString" }
    password_digest { "MyString" }
    api_key { "" }
  end
end
