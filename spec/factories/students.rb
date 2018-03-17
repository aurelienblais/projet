FactoryBot.define do
  factory :student do
    sequence(:name) { |n| "Firstname #{n}" }
    sequence(:lastname) { |n| "Lastname #{n}" }
    birthdate '01/01/01'
  end
end
