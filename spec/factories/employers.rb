FactoryBot.define do
  factory :employer do
    email { generate(:email) }
    password { '123456' }
  end
end
