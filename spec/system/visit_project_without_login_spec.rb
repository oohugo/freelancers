require 'rails_helper'

# describe 'Visitor visit project page' do
#   it 'cannot do without login' do
#     employer = Employer.create!(email: 'joao@email.com', password: '123456')
#     site = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
#                            max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
#                            status: :avaliable, employer: employer)

#     visit project_path(site)
#     expect(page).not_to have_content('Site de freelancer')
#     expect(page).not_to have_content('Descrição: Site para contratar freelancers')
#     expect(page).not_to have_content('Valor máximo por hora: R$ 10,00')
#     expect(page).not_to have_content("Data limite: #{I18n.l(5.days.from_now.to_date)}")
#     expect(page).not_to have_content('Locação: Remoto')
#     expect(page).not_to have_content('Avaliação do Empregador: Ainda não avaliado')
#     expect(page).to have_content('Entrar como empregador')
#     expect(page).to have_content('Entrar como freelancer')
#   end
# end
