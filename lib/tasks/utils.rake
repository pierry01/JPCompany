require 'faker'

namespace :utils do
  desc 'Cria administradores fake'
  
  task generate_admins: :environment do
    puts 'Cadastrando ADMINISTRADORES...'
    10.times do
      Admin.create!( 
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: 123456,
        password_confirmation: 123456 )
    end
    puts 'Cadastrando ADMINISTRADORES... [OK]'
  end
end
