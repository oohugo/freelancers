FactoryBot.define do
  factory :feedback do
    rating { 2 }
    comment { 'Comentário sobre o projeto' }
    feedbackable { worker }
    project

    trait :for_worker do
      feedbackable { worker }
    end

    trait :for_employer do
      feedbackable { employer }
    end
  end
end
