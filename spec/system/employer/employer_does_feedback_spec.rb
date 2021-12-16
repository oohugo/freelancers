require 'rails_helper'
describe 'Employer does feedback of employer' do
  it 'successfully' do
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = create(:project, title: 'Site de freelancer', employer: employer, status: :finished)
    create(:proposal, project: project, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_link 'Dar feedback aos freelancers'
    fill_in 'Nota de 1 a 5', with: 4
    fill_in 'Comentário', with: 'Muito bom profissional'
    click_on 'Enviar'

    expect(page).to have_content('Feedback enviado')
  end

  it 'and employer see rating of freelancer' do
    worker = create(:worker)
    perfil_worker = create(:perfil_worker, worker: worker)
    employer = create(:employer)
    create(:feedback, rating: 5, feedbackable: worker)
    create(:feedback, rating: 2, feedbackable: worker)
    worker.reload
    worker.feedbacks.map(&:save)

    login_as employer, scope: :employer
    visit perfil_worker_path(perfil_worker)

    expect(page).to have_content("Avaliação do freelancer: #{(5 + 2) / 2}")
  end

  it 'bank' do
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = create(:project, title: 'Site de freelancer', employer: employer, status: :finished)
    create(:proposal, project: project, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_link 'Dar feedback aos freelancers'
    fill_in 'Nota de 1 a 5', with: ''
    fill_in 'Comentário', with: ''
    click_on 'Enviar'

    expect(page).not_to have_content('Feedback enviado')
    expect(page).to have_content('Nota de 1 a 5')
    expect(page).to have_content('Nota não pode ficar em branco')
    expect(page).to have_content('Comentário não pode ficar em branco')
  end
end
