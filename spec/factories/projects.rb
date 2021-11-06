FactoryBot.define do
  factory :project do
    title        { 'Projeto para Freelancers' }
    description  { 'Um projetoa para receber freelancers' }
    max_per_hour { 30.0 }
    deadline     { 6.weeks.from_now.to_date }
    place        { 'remote' }
    employer
  end
end
