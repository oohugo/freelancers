FactoryBot.define do
  factory :proposal do
    description  { 'Um projetoa para receber freelancers' }
    hourly_value { 20.0 }
    hours_per_week { 25 }
    date_close { 4.weeks.from_now.to_date }
    project
    worker
  end
end
