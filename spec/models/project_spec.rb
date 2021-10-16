require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Validations' do
    context 'present' do
      let(:project) { Project.new }
      it 'title must pe present' do
        project.valid?
        expect(project.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')
      end
      it 'description must pe present' do
        project.valid?
        expect(project.errors.full_messages_for(:description)).to include('Descrição não pode ficar em branco')
      end
      it 'max per hour must pe present' do
        project.valid?
        expect(project.errors.full_messages_for(:max_per_hour)).to include('Valor máximo por hora não pode ficar em branco')
      end
      it 'deadline must pe present' do
        project.valid?
        expect(project.errors.full_messages_for(:deadline)).to include('Data limite não pode ficar em branco')
      end
      it 'place must pe present' do
        project.valid?
        expect(project.errors.full_messages_for(:place)).to include('Locação não pode ficar em branco')
      end
    end
    it 'max per hour must be greater than 0' do
      project = Project.new(max_per_hour: -1)
      project.valid?
      expect(project.errors.full_messages_for(:max_per_hour)).to include('Valor máximo por hora deve ser maior que 0')
    end
    it 'deadline cannot be in past' do
      project = Project.new(deadline: 1.days.ago)
      project.valid?
      expect(project.errors.full_messages_for(:deadline)).to include('Data limite não pode ser em datas passadas')
    end
    it 'place must be remote or presential' do
      project = Project.new(place: 'qualquercoisa')
      project.valid?
      expect(project.errors.full_messages_for(:place)).to include('Locação não pode ser uma opção não especificada')
    end
  end
end
