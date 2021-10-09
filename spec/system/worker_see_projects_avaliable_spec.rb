require 'rails_helper'

describe 'Worker see projects' do
  it 'avaliables' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                          birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                          expertise: 'Web', worker: worker)
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Remoto', status: :avaliable)
    Project.create!(title: 'Site de locação', description: 'Site para alugar imóveis',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Presencial', status: :canceled)

    login_as worker, scope: :worker
    visit root_path

    expect(page).to have_content('Projetos disponíveis')
    expect(page).to have_content('Site de freelancer')
    expect(page).not_to have_content('Site de locação')
  end

  it 'details' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                         birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                         expertise: 'Web', worker: worker)
    date = 5.days.from_now.to_date
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: date, place: 'Remoto', status: :avaliable)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'

    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Descrição: Site para contratar freelancers')
    expect(page).to have_content('Máximo por hora: R$ 10,00')
    expect(page).to have_content("Data limite: #{date}")
    expect(page).to have_content('Atuação: Remoto')
  end
end
