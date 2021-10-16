require 'rails_helper'

RSpec.describe PerfilWorker, type: :model do
  context 'Validations' do
    context 'present' do
      let(:perfil_worker) { PerfilWorker.new }
      it 'full name must pe present' do
        perfil_worker.valid?
        expect(perfil_worker.errors.full_messages_for(:full_name)).to include('Nome completo não pode ficar em branco')
      end
      it 'birthdate must pe present' do
        perfil_worker.valid?
        expect(perfil_worker.errors.full_messages_for(:birthdate)).to include('Data de nascimento não pode ficar em branco')
      end
      it 'qualification must pe present' do
        perfil_worker.valid?
        expect(perfil_worker.errors.full_messages_for(:qualification)).to include('Formação não pode ficar em branco')
      end
      it 'background must pe present' do
        perfil_worker.valid?
        expect(perfil_worker.errors.full_messages_for(:background)).to include('Experiência não pode ficar em branco')
      end
      it 'expertise must pe present' do
        perfil_worker.valid?
        expect(perfil_worker.errors.full_messages_for(:expertise)).to include('Área de atuação não pode ficar em branco')
      end
    end
  end
  it 'birthdate must be a lest eighteen old' do
    perfil_worker = PerfilWorker.new(birthdate: 10.years.ago.to_date)
    perfil_worker.valid?
    expect(perfil_worker.errors.full_messages_for(
             :birthdate
           )).to include('Data de nascimento tem que ter mais de 18 anos para criar um perfil')
  end
end
