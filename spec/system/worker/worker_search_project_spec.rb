require 'rails_helper'

describe 'Worker search for projects' do
  it 'avaliables' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = create(:employer)
    create(:perfil_worker, worker: worker)
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote', employer: employer)
    Project.create!(title: 'Site de locação', description: 'Site para alugar imóveis',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'presential',
                    employer: employer)

    login_as worker, scope: :worker
    visit root_path
    fill_in 'Pesquisar projetos com:', with: 'locação'
    click_on 'Buscar'

    expect(page).not_to have_content('Site de freelancer')
    expect(page).to have_content('Site de locação')
  end
end
