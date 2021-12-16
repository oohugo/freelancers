require 'rails_helper'

RSpec.describe Feedback, type: :model do
  context 'Validations' do
    context 'present' do
      let(:feedback) { Feedback.new }
      it 'comment must be present' do
        feedback.valid?
        expect(feedback.errors.full_messages_for(:comment)).to include('Comentário não pode ficar em branco')
      end
      it 'rating must be present' do
        feedback.valid?
        expect(feedback.errors.full_messages_for(:rating)).to include('Nota não pode ficar em branco')
      end
      it 'feedbackable must be present' do
        feedback.valid?
        expect(feedback.errors.full_messages_for(:feedbackable)).to include('Feedbackable não pode ficar em branco')
      end
    end
    context 'numericality' do
      it 'rating must be more than 0' do
        feedback = Feedback.new(rating: -10)
        feedback.valid?
        expect(feedback.errors.full_messages_for(:rating)).to include('Nota deve ser maior ou igual a 0')
      end
      it 'rating must be less than 5' do
        feedback = Feedback.new(rating: 10)
        feedback.valid?
        expect(feedback.errors.full_messages_for(:rating)).to include('Nota deve ser menor ou igual a 5')
      end
    end
  end
end
