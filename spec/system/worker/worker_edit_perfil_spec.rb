require 'rails_helper'

describe 'Freelancer edit perfil' do
  it 'successfully' do
    worker = Worker.create!(email: 'joao@email.com', password: '123456')
    perfil = PerfilWorker.create!(full_name: 'João Severino', birthdate: '18/07/1992',
                                  qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                                  expertise: 'Desenvolvimento', worker: worker)
    perfil.photo.attach(io: File.open('spec/support/hades.png'), filename: 'hades.png')

    login_as worker, scope: :worker
    visit root_path
    click_on 'Editar perfil'
    fill_in 'Nome social', with: 'João'
    fill_in 'Formação', with: 'Graduado em Ciências da Computação e pos em Matemática'
    fill_in 'Experiência', with: 'Estágio em web e junior em ruby on rails'
    fill_in 'Área de atuação', with: 'Web'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'pexels.jpg')
    click_on 'Enviar'
    click_on 'Perfil'

    expect(page).to have_content('Nome completo: João Severino')
    expect(page).to have_content('Nome social: João')
    expect(page).to have_content('Data de nascimento: 18/07/1992')
    expect(page).to have_content('Formação: Graduado em Ciências da Computação e pos em Matemática')
    expect(page).to have_content('Experiência: Estágio em web e junior em ruby on rails')
    expect(page).to have_content('Área de atuação: Web')
    expect(page).to have_css('img[src*="pexels.jpg"]')
  end
end
