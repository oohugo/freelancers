FactoryBot.define do
  factory :feedback do
    rating { 2 }
    comment { 'Comentário sobre o projeto' }
    association :feedbackable, factory: :worker
    project

    trait :for_worker do
      association :feedbackable, factory: :worker
    end

    trait :for_employer do
      association :feedbackable, factory: :employer
    end
  end
end
