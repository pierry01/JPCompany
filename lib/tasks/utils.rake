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
        password_confirmation: 123456,
        role: 1
      )
    end
    puts 'Cadastrando ADMINISTRADORES... [OK]'
  end
  
  desc 'Cria anúncios fake'
  task generate_ads: :environment do
    puts 'Cadastrando ANÚNCIOS...'
    100.times do
      Ad.create!( 
        title: Faker::Lorem.sentence([2..5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category: Category.all.sample
      )
    end
    puts 'Cadastrando ANÚNCIOS... [OK]'
  end
end
