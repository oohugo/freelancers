require 'rails_helper'

describe 'Employer log in' do
  it 'successfully' do
    joao = Employer.create!(email: 'joao@email.com', password: '123456')

    visit root_path
    expect(page).not_to have_content(joao.email)
    click_on 'Entrar como empregador'
    fill_in 'Email', with: joao.email
    fill_in 'Senha', with: joao.password
    click_on 'Log in'

    expect(page).to have_content('joao@email.com')
    expect(page).to have_content('Criar Projeto')
    expect(page).not_to have_content('Entrar como empregador')
  end
end
