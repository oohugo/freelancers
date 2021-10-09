require 'rails_helper'

describe 'Freelancer registers perfil' do
  it 'successfully' do
    freelancer = Worker.create!(email: 'joao@email.com', password: '123456')

    login_as freelancer, scope: :worker
    visit root_path
    fill_in 'Nome completo', with: 'João Severino'
    fill_in 'Nome social', with: 'Severino'
    fill_in 'Data de nascimento', with: '18/07/1992'
    fill_in 'Formação', with: 'Graduado em Ciências da Computação'
    fill_in 'Experiência', with: 'Estágio blabla bla'
    fill_in 'Área de atuação', with: 'Desenvolvimento'
    click_on 'Criar perfil'

    expect(page).to have_content('Projetos disponíveis')
    expect(page).not_to have_content('Nome completo')
  end
end
