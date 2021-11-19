require 'rails_helper'

describe 'Freelancer registers himself' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar como freelancer'
    click_on 'Sign up'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_content('joao@email.com')
    expect(page).not_to have_content('Entrar como freelancer')
    expect(page).to have_content('Logout')
    expect(page).to have_content('É necessário criar perfil para ver projetos')
    expect(page).to have_content('Criar perfil')
  end
end
