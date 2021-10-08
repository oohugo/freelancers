# coding: utf-8
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
    end

    it 'cannot have less o equal to zero in max_per_hour' do
      # todo
    end

    it 'cannot have deadline in future' do
      #todo
    end
  end
end
