require 'rails_helper'

describe 'Employer authentication' do
  context 'project' do
    it 'cannot create project without login' do
      post '/projects'
      expect(response).to redirect_to(new_employer_session_path)
    end
    it 'cannot see forms of new project without login' do
      get '/projects/new'
      expect(response).to redirect_to(new_employer_session_path)
    end
    it 'cannot suspend a project without login' do
      post '/projects/1/suspend'
      expect(response).to redirect_to(new_employer_session_path)
    end

    it 'cannot finished a project without login' do
      post '/projects/1/finished'
      expect(response).to redirect_to(new_employer_session_path)
    end
  end

  context 'proposal' do
    it 'cannot accepted a proposal without login' do
      post '/proposals/1/accepted'
      expect(response).to redirect_to(new_employer_session_path)
    end
    it 'cannot rejected a proposal without login' do
      post '/proposals/1/rejected'
      expect(response).to redirect_to(new_employer_session_path)
    end
  end

  context 'feedback' do
    it 'cannot create feedback for freelancer without login' do
      post '/projects/1/workers/1/feedbacks'
      expect(response).to redirect_to(root_path)
    end
  end
end
