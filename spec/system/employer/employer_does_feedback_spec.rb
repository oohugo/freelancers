require 'rails_helper'
describe 'Employer does feedback of employer' do
  it 'successfully' do
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = create(:project, title: 'Site de freelancer', employer: employer, status: :finished)
    create(:proposal, project: project, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Dar feedback aos freelancers'
    fill_in 'Nota de 1 a 5', with: 4
    fill_in 'Comentário', with: 'Muito bom profissional'
    click_on 'Enviar'

    expect(page).to have_content('Feedback enviado')
  end

  it 'and employer see rating of freelancer' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    perfil_worker = create(:perfil_worker, worker: worker)
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    FeedbackWorker.create!(comment: 'Fez tudo certo', rating: 5, worker: worker)
    FeedbackWorker.create!(comment: 'Fez tudo errado', rating: 2, worker: worker)
    worker.calculate_rating
    worker.save!
    login_as employer, scope: :employer
    visit perfil_worker_path(perfil_worker)

    expect(page).to have_content("Avaliação do freelancer: #{(5 + 2) / 2}")
  end
end
