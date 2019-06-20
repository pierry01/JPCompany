require 'faker'

namespace :utils do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Apagando DB...') { %x(rake db:drop) }
      show_spinner('Criando DB...') { %x(rake db:create) }
      show_spinner('Migrando DB...') { %x(rake db:migrate) }
      show_spinner('Faker: Cadastrando ADMINISTRADORES...') { %x(rake utils:generate_admins)}
      show_spinner('Faker: Cadastrando USERS...') { %x(rake utils:generate_users)}
      show_spinner('Faker: Cadastrando ANÚNCIOS...') { %x(rake utils:generate_ads)}
      show_spinner('Cadastrando ADMINISTRADOR PADRÃO...') { %x(rake utils:generate_admin)}
      show_spinner('Cadastrando USER PADRÃO...') { %x(rake utils:generate_user)}
      show_spinner('Cadastrando CATEGORIAS PADRÕES...') { %x(rake utils:generate_categories)}
    else
      puts 'Você não está em ambiente de desenvolvimento!'
    end
  end
  
  desc 'Cria ADMINS fakes'
  task generate_admins: :environment do
    10.times do
      Admin.create!( 
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: 123456,
        password_confirmation: 123456,
        role: 1
      )
    end
  end
  
  desc 'Cria ADS fake'
  task generate_ads: :environment do
    100.times do
      Ad.create!( 
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        user: User.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end
  end
  
  desc 'Cria CATEGORIES padrões'
  task generate_categories: :environment do
    categories = [ 'Animais',
                   'Acessórios',
                   'Esportes',
                   'Eletrônicos',
                   'Celulares',
                   'Música',
                   'Hobbies',
                   'Moda',
                   'Veículos',
                   'Imóveis' ]
                   
    categories.each do |category|
      Category.find_or_create_by(description: category)
    end
  end
  
  desc 'Cria o ADMIN padrão'
  task generate_admin: :environment do
      Admin.create!( 
        name: 'Admin Padrão',
        email: 'admin@admin.com',
        password: 123456,
        password_confirmation: 123456,
        role: 0 
      )
  end
  
  desc 'Cria o USER padrão'
  task generate_user: :environment do
      User.create!( 
        email: 'user@user.com',
        password: 123456,
        password_confirmation: 123456,
      )
  end
  
  desc 'Cria USERS fake'
  task generate_users: :environment do
    100.times do
      User.create!( 
        email: Faker::Internet.email,
        password: 123456,
        password_confirmation: 123456
      )
    end
  end
  
  private
  
  def show_spinner(msg_start, msg_end = 'Concluído!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
