require 'rails_helper'

describe 'Freelancer does feedback of employer' do
  it 'successfully' do
    worker = create(:worker)
    employer = create(:employer, email: 'employer@email.com')
    create(:perfil_worker, worker: worker)
    project = create(:project, title: 'Site de freelancer', status: :finished, employer: employer)
    create(:proposal, project: project, worker: worker, status: :accepted)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Dar feedback ao Empregador'
    fill_in 'Nota de 1 a 5', with: 4
    fill_in 'Comentário', with: 'Muito bom profissional'
    fill_in 'Comentário do projeto', with: 'Adorei trabalhar neste projeto'
    click_on 'Enviar'

    expect(page).to have_content('Feedback enviado')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Avaliação do Empregador: 4')
  end

  it 'and freelancer see rating of employer' do
    worker = create(:worker)
    create(:perfil_worker, worker: worker)
    employer = create(:employer)
    create(:feedback, rating: 5, feedbackable: employer)
    create(:feedback, rating: 2, feedbackable: employer)
    create(:project, title: 'Site de freelancer', employer: employer)
    project_finished = create(:project, title: 'Site de locação', status: :finished, employer: employer)
    FeedbackProject.create!(comment: 'Projeto muito bem feito pelo Empregador', project: project_finished)
    employer.reload
    employer.feedbacks.map(&:save)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on employer.email

    expect(page).to have_content('Site de locação')
    expect(page).to have_content('Projeto muito bem feito pelo Empregador')
    expect(page).to have_content("Avaliação do Empregador: #{(5 + 2) / 2}")
  end
end
