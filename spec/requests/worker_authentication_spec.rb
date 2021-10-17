require 'rails_helper'

describe 'Worker authentication' do
  context 'perfil of freelancer' do
    it 'cannot create perfil without login' do
      post '/perfil_workers'
      expect(response).to redirect_to(new_worker_session_path)
    end
    it 'cannot see forms for new perfil without login' do
      get '/perfil_workers/new'
      expect(response).to redirect_to(new_worker_session_path)
    end
  end
  context 'proposal' do
    it 'cannot create proposal without login' do
      post '/projects/1/proposals/'
      expect(response).to redirect_to(new_worker_session_path)
    end
    it 'cannot cancel a proposal without login' do
      post '/proposals/1/cancel'
      expect(response).to redirect_to(new_worker_session_path)
    end
  end
  context 'feedback' do
    it 'cannot create feedback for employer without login' do
      post '/projects/1/feedback_employers'
      expect(response).to redirect_to(new_worker_session_path)
    end
  end
end
