FactoryBot.define do
  factory :user do
    email { "email@example.com" }
    password_digest { "MyString" }
    api_key { "ABC123" }
  end
end
