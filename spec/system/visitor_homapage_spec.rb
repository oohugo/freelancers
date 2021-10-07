require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfuly' do
    visit root_path

    expect(page).to have_css('h1', text: 'Freelancers')
    expect(page).to have_content('Entrar como empregador')
    expect(page).to have_content('Entrar como freelancer')
  end
end
