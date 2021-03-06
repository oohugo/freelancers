require 'rails_helper'

describe 'Employer registers himself' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar como empregador'
    click_on 'Sign up'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_content('joao@email.com')
    expect(page).not_to have_content('Entrar como empregador')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('Criar Projeto')
  end
end
