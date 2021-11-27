FactoryBot.define do
  factory :worker do
    email { generate(:email) }
    password { '123456' }

    after(:create) do |worker|
      create(:feedback, feedbackable: worker)
    end
  end
end

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@email.com"
  end
end
