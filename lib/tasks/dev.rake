require 'faker'

namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    images_path = Rails.root.join('public', 'system')
    
    if Rails.env.development?
      show_spinner('Apagando DB...') { %x(rake db:drop) }
      show_spinner('Apagando public/system...') { %x(rm -rf #{images_path})}
      show_spinner('Criando DB...') { %x(rake db:create) }
      show_spinner('Migrando DB...') { %x(rake db:migrate) }
      show_spinner('Faker: Cadastrando ADMINISTRADORES...') { %x(rake dev:generate_admins)}
      show_spinner('Faker: Cadastrando USERS...') { %x(rake dev:generate_users)}
      show_spinner('Cadastrando CATEGORIAS PADRÕES...') { %x(rake dev:generate_categories)}
      show_spinner('Faker: Cadastrando ANÚNCIOS...') { %x(rake dev:generate_ads)}
      show_spinner('Cadastrando ADMINISTRADOR PADRÃO...') { %x(rake dev:generate_admin)}
      show_spinner('Cadastrando USER PADRÃO...') { %x(rake dev:generate_user)}
      show_spinner('Cadastrando ADS para o USER PADRÃO...') { %x(rake dev:generate_ads_to_user)}
      show_spinner('Faker: Cadastrando COMENTÁRIOS...') { %x(rake dev:generate_comments)}
    else
      puts 'Você não está em ambiente de desenvolvimento!'
    end
  end
  
  #########################################
  
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
  
  #########################################
    
  desc 'Cria ADS fake'
  task generate_ads: :environment do
    50.times do
      Ad.create!( 
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph,
        user: User.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates',
          'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end
  end
  
  #########################################
  
  desc 'Cria ADS para o USER PADRÃO'
  task generate_ads_to_user: :environment do
    10.times do
      Ad.create!( 
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph,
        user: User.last,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates',
          'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end
  end
  
  #########################################
  
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
  
  #########################################
  
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
  
  #########################################
  
  desc 'Cria o USER padrão'
  task generate_user: :environment do
    User.create!( 
      email: 'user@user.com',
      password: 123456,
      password_confirmation: 123456,
    )
  end
  
  #########################################
  
  desc 'Cria USERS fake'
  task generate_users: :environment do
    10.times do
      User.create!( 
        email: Faker::Internet.email,
        password: 123456,
        password_confirmation: 123456
      )
    end
  end
  
  #########################################

  desc 'Cria COMENTÁRIOS fake'
  task generate_comments: :environment do
    Ad.all.each do |ad|
      (Random.rand(5)).times do
        Comment.create!(
          body: Faker::Lorem.paragraph,
          user: User.all.sample,
          ad: ad
        )
      end
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
