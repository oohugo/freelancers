require 'rails_helper'

describe 'Employer edit a project' do
  it 'stopping receiving proposals' do
    worker = create(:worker)
    employer = create(:employer)
    project = create(:project, title: 'Site de freelancer', employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker)

    Proposal.create!(description: 'Especialista em webdesenvolvimento', hourly_value: 6.0,
                     hours_per_week: 25, date_close: 3.days.from_now,
                     project: project, worker: worker, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Suspender propostas'

    expect(page).to have_content('Especialista em webdesenvolvimento')
    expect(page).not_to have_content('Sou bom em fazer sites')
    expect(page).not_to have_content('Valor por hora: R$ 7,00')
    expect(page).not_to have_content('Horas disponíveis por semana: 20')
    expect(page).not_to have_content("Previsão de conclusão: #{4.days.from_now.to_date}")
  end

  it 'returning to receive proposals' do
    worker = create(:worker)
    employer = create(:employer)
    create(:project, title: 'Site de freelancer', description: 'Site para contratar freelancers',
                     employer: employer, status: :suspend)
    create(:perfil_worker, worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Deixar disponível para propostas'
    logout(:employer)
    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Descrição da proposta', with: 'texto justificando a proposta'
    fill_in 'Valor da hora', with: 7.0
    fill_in 'Horas disponíveis por semana', with: 20
    fill_in 'Expectativa de conclusão', with: 4.days.from_now
    click_on 'Enviar'

    expect(page).to have_content('Proposta enviada')
    expect(page).to have_content('Cancelar a proposta')
    expect(page).to have_content('Site para contratar freelancers')
  end

  it '... finished a project' do
    worker = Worker.create!(email: 'worker@email.com', password: '123456')
    employer = create(:employer)
    project = create(:project, title: 'Site de freelancer', employer: employer)
    create(:proposal, project: project, worker: worker, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Finalizar projeto'

    expect(page).to have_content('Projeto finalizado')
    expect(page).to have_content('Feedback')
    expect(page).to have_content('worker@email.com')
  end
end
