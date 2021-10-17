require 'rails_helper'

describe 'Employer see proposal' do
  it 'succefully' do
    employer = Employer.create!(email: 'joao@email.com', password: '123456')
    worker = Worker.create!(email: 'worker@email.com', password: '123456')
    site = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                           max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                           status: :avaliable, employer: employer)
    app = Project.create!(title: 'Jogo mobile', description: 'Jogo para celulares android',
                          max_per_hour: 40.0, deadline: 50.days.from_now, place: 'remote',
                          status: :avaliable, employer: employer)
    date = 4.days.from_now.to_date
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: date,
                     project: site, worker: worker)
    Proposal.create!(description: 'Experiencia em app mobiles', hourly_value: 9.0,
                     hours_per_week: 15, date_close: 30.days.from_now,
                     project: app, worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Valor por hora: R$ 7,00')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content("Previsão de conclusão: #{date}")
    expect(page).to have_content('Status: pending')
    expect(page).to have_content('Perfil do freelancer: worker@email.com')
    expect(page).to have_content('Aceitar proposta')
    expect(page).to have_content('Rejeitar proposta')
    expect(page).not_to have_content('Experiencia em app mobiles')
    expect(page).not_to have_content('R$ 9,00')
    expect(page).not_to have_content('por semana: 15')
    expect(page).not_to have_content(30.days.from_now.to_date.to_s)
  end

  it 'and see perfil of freelancer' do
    employer = Employer.create!(email: 'joao@email.com', password: '123456')
    worker = Worker.create!(email: 'worker@email.com', password: '123456')
    perfil = PerfilWorker.create!(full_name: 'João Severino', birthdate: '18/07/1992',
                                  qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                                  expertise: 'Desenvolvimento', worker: worker)
    perfil.photo.attach(io: File.open('app/assets/images/treinadev.svg'), filename: 'name.svg')
    site = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                           max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                           status: :avaliable, employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: site, worker: worker)
    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Perfil do freelancer'

    expect(page).to have_content('Perfil do worker@email.com')
    expect(page).to have_css('img[alt=Foto]')
    expect(page).to have_content('Nome completo: João Severino')
    expect(page).to have_content('Data de nascimento: 18/07/1992')
    expect(page).to have_content('Formação: Graduado em Ciências da Computação')
    expect(page).to have_content('Experiência: Estágio blabla bla')
    expect(page).to have_content('Área de atuação: Desenvolvimento')
    expect(page).to have_content('Avaliação do freelancer: Ainda não avaliado')
  end
end
