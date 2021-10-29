# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
joao = Worker.create!(email: 'joao@email.com', password: '123456')
PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                     qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                     expertise: 'Desenvolvimento', worker: joao)
marcus = Employer.create!(email: 'marcus@email.com', password: '123456')
site1 = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                        max_per_hour: 30.0, deadline: 50.days.from_now, place: 'remote', employer: marcus)
Project.create!(title: 'Site de locação', description: 'Site para alugar imóveis',
                max_per_hour: 40.0, deadline: 50.days.from_now, place: 'presential',
                status: :suspend, employer: marcus)
Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 9.0,
                 hours_per_week: 20, date_close: 40.days.from_now,
                 project: site1, worker: joao)

maria = Worker.create!(email: 'maria@email.com', password: '123456')
joana = Employer.create!(email: 'joana@email.com', password: '123456')
project = Project.create!(title: 'Jogo de celular', description: 'Jogo mobile muito divertido',
                          max_per_hour: 30.0, deadline: 30.days.from_now, place: 'remote',
                          employer: joana)
Project.create!(title: 'Jogo de Computador', description: 'Jogo computador muito divertido',
                max_per_hour: 30.0, deadline: 60.days.from_now, place: 'remote',
                employer: joana)
Proposal.create!(description: 'Sou bom em fazer jogos', hourly_value: 7.0,
                 hours_per_week: 20, date_close: 20.days.from_now,
                 project: project, worker: maria)

