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


end
