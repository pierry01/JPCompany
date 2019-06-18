puts 'Cadastrando CATEGORIAS...'
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
puts 'Cadastrando CATEGORIAS... [OK]'

puts 'Cadastrando ADMINISTRADOR PADRÃO...'
  Admin.create!( 
    name: 'Admin Padrão',
    email: 'admin@admin.com',
    password: 123456,
    password_confirmation: 123456 )
puts 'Cadastrando ADMINISTRADOR PADRÃO... [OK]'