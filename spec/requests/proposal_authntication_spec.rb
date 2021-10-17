require 'rails_helper'

describe 'proposal authentication' do
  it 'cannot create proposal in suspend projects' do
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: Employer.create!(email: 'employer@email.com', password: '123456'),
                              status: :suspend)
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    login_as worker, scope: :worker
    post "/projects/#{project.id}/proposals"

    expect(response).to redirect_to(project_path(project))
  end
  it 'cannot create proposal in finished projects' do
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: Employer.create!(email: 'employer@email.com', password: '123456'),
                              status: :finished)
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    login_as worker, scope: :worker
    post "/projects/#{project.id}/proposals"

    expect(response).to redirect_to(project_path(project))
  end
end
