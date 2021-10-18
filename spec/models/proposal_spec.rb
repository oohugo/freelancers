require 'rails_helper'

RSpec.describe Proposal, type: :model do
  context 'validations' do
    context 'present' do
      let(:proposal) { Proposal.new }
      it 'description must be present' do
        proposal.valid?
        expect(proposal.errors.full_messages_for(:description)).to include('Descrição da proposta não pode ficar em branco')
      end
      it 'hour value must be present' do
        proposal.valid?
        expect(proposal.errors.full_messages_for(:hourly_value)).to include('Valor da hora não pode ficar em branco')
      end
      it 'hours per week must be present' do
        proposal.valid?
        expect(proposal.errors.full_messages_for(:hours_per_week)).to include('Horas disponíveis por semana não pode ficar em branco')
      end
      it 'date close must be present' do
        proposal.valid?
        expect(proposal.errors.full_messages_for(:date_close)).to include('Expectativa de conclusão não pode ficar em branco')
      end
    end
    context 'greater than zero' do
      it 'hours per week must be grater than zero' do
        proposal = Proposal.new(hours_per_week: -1)
        proposal.valid?
        expect(proposal.errors.full_messages_for(:hours_per_week)).to include('Horas disponíveis por semana deve ser maior que 0')
      end
      it 'hourly value must be grater than zero' do
        proposal = Proposal.new(hourly_value: -1)
        proposal.valid?
        expect(proposal.errors.full_messages_for(:hourly_value)).to include('Valor da hora deve ser maior que 0')
      end
    end
    it 'date close must be in future' do
      proposal = Proposal.new(date_close: 2.days.ago)
      proposal.valid?
      expect(proposal.errors.full_messages_for(:date_close)).to include('Expectativa de conclusão deve estar no futuro')
    end
    it 'date close must be less than deadline of project' do
      proposal = Proposal.new(date_close: 20.days.from_now)
      proposal.project = Project.new(deadline: 10.days.from_now)
      proposal.valid?
      expect(proposal.errors.full_messages_for(:date_close)).to include('Expectativa de conclusão deve ser mais cedo que a data limite do projeto')
    end
  end
end
