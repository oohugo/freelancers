# frozen_string_literal: true

require 'rails_helper'

describe 'Freelancer registers perfil' do
  context 'create' do
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
      attach_file 'Foto', Rails.root.join('spec/support/hades.png')
      click_on 'Criar perfil'

      expect(page).to have_content('Pesquisar projetos')
      expect(page).not_to have_content('Nome completo')
    end

    it 'successfully and see perfil' do
      freelancer = Worker.create!(email: 'joao@email.com', password: '123456')

      login_as freelancer, scope: :worker
      visit root_path
      fill_in 'Nome completo', with: 'João Severino'
      fill_in 'Nome social', with: 'Severino'
      fill_in 'Data de nascimento', with: '18/07/1992'
      fill_in 'Formação', with: 'Graduado em Ciências da Computação'
      fill_in 'Experiência', with: 'Estágio blabla bla'
      fill_in 'Área de atuação', with: 'Desenvolvimento'
      attach_file 'Foto', Rails.root.join('spec/support/hades.png')
      click_on 'Criar perfil'
      click_on 'Perfil'

      expect(page).not_to have_content('Pesquisar projetos')
      expect(page).to have_content('Nome completo: João Severino')
      expect(page).to have_content('Nome social: Severino')
      expect(page).to have_content('Data de nascimento: 18/07/1992')
      expect(page).to have_content('Formação: Graduado em Ciências da Computação')
      expect(page).to have_content('Experiência: Estágio blabla bla')
      expect(page).to have_content('Área de atuação: Desenvolvimento')
      expect(page).to have_css('img[src*="hades.png"]')
    end
  end

  context 'validations' do
    it 'cannot have perfil in blank' do
      freelancer = Worker.create!(email: 'joao@email.com', password: '123456')

      login_as freelancer, scope: :worker
      visit root_path
      fill_in 'Nome completo', with: ''
      fill_in 'Data de nascimento', with: ''
      fill_in 'Formação', with: ''
      fill_in 'Experiência', with: ''
      fill_in 'Área de atuação', with: ''
      click_on 'Criar perfil'

      expect(page).not_to have_content('projetos disponíveis')
      expect(page).to have_content('Nome completo')
      expect(page).to have_content('não pode ficar em branco')
    end

    it 'cannot be less than 18 yers old' do
      freelancer = Worker.create!(email: 'joao@email.com', password: '123456')

      login_as freelancer, scope: :worker
      visit root_path
      fill_in 'Nome completo', with: 'João Severino'
      fill_in 'Nome social', with: 'Severino'
      fill_in 'Data de nascimento', with: 10.years.ago
      fill_in 'Formação', with: 'Graduado em Ciências da Computação'
      fill_in 'Experiência', with: 'Estágio blabla bla'
      fill_in 'Área de atuação', with: 'Desenvolvimento'
      click_on 'Criar perfil'

      expect(page).not_to have_content('projetos disponíveis')
      expect(page).to have_content('Nome completo')
      expect(page).to have_content('tem que ter mais de 18 anos para criar um perfil')
    end
  end
end
