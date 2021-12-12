require 'rails_helper'

describe 'Worker cancel a proposal' do
  it 'successfully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    create(:perfil_worker, worker: worker)
    create(:proposal, project: create(:project, title: 'Site de freelancer'), worker: worker, status: :pending)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Cancelar a proposta'

    expect(page).to have_content('Proposta cancelada')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Descrição da proposta')
    expect(page).not_to have_content('Cancelar a proposta')
  end

  it 'justification in cancel a proposal after 3 days confirmed' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    create(:perfil_worker, worker: worker)
    project = create(:project, title: 'Site de freelancer')
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker, status: :accepted,
                     date_accepted: 1.day.ago)
    travel 4.days
    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Justifique o cancelamento', with: 'Imprevisto aconteceu'
    click_on 'Cancelar a proposta'

    expect(page).to have_content('Proposta cancelada')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Descrição da proposta')
    expect(page).not_to have_content('Cancelar a proposta')
  end
end
