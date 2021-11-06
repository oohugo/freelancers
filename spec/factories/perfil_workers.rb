# frozen_string_literal: true

FactoryBot.define do
  factory :perfil_worker do
    full_name { 'João Severino' }
    birthdate { 19.years.ago.to_date }
    qualification { 'Graduado em Ciências da Computação' }
    background { 'Experiencia em Sites com Ruby on Rails ' }
    expertise { 'Web Desenvolvimento' }
    worker
  end
end
