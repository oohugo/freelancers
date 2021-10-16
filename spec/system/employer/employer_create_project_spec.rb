require 'rails_helper'

describe 'Employer create project' do
  it 'successfully' do
    employer = Employer.create!(email: 'joao@email.com', password: '123456')

    login_as employer, scope: :employer
    visit root_path
    click_on 'Criar Projeto'

    fill_in 'Título', with: 'Site de freelancers'
    fill_in 'Descrição', with: 'Site para freelancers encontrarem projetos'
    fill_in 'Valor máximo por hora', with: 10.50
    fill_in 'Data limite', with: '17/10/2021'
    choose 'Remoto'
    click_on 'Criar'

    expect(page).to have_content 'Site de freelancers'
  end

  context 'Validation' do
    it 'cannot have project blank' do
      employer = Employer.create!(email: 'joao@email.com', password: '123456')

      login_as employer, scope: :employer
      visit root_path
      click_on 'Criar Projeto'

      fill_in 'Título', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Valor máximo por hora', with: ''
      fill_in 'Data limite', with: ''
      click_on 'Criar'

      expect(page).to have_content 'não pode ficar em branco'
      expect(page).to have_content 'Título'
    end

    it 'cannot have less o equal to zero in max_per_hour' do
      employer = Employer.create!(email: 'joao@email.com', password: '123456')
      login_as employer, scope: :employer
      visit root_path
      click_on 'Criar Projeto'
      fill_in 'Título', with: 'Site de freelancer'
      fill_in 'Descrição', with: 'Site para freelancers'
      fill_in 'Valor máximo por hora', with: '-1'
      fill_in 'Data limite', with: 50.days.from_now
      choose 'Remoto'
      click_on 'Criar'

      expect(page).to have_content('Valor máximo por hora deve ser maior que 0')
      expect(page).to have_content('Título')
    end

    it 'cannot have deadline in past' do
      employer = Employer.create!(email: 'joao@email.com', password: '123456')
      login_as employer, scope: :employer
      visit root_path
      click_on 'Criar Projeto'
      fill_in 'Título', with: 'Site de freelancer'
      fill_in 'Descrição', with: 'Site para freelancers'
      fill_in 'Valor máximo por hora', with: '10.8'
      fill_in 'Data limite', with: 1.days.ago
      choose 'Remoto'
      click_on 'Criar'

      expect(page).to have_content('Data limite não pode ser em datas passadas')
      expect(page).to have_content('Título')
    end
  end
end
