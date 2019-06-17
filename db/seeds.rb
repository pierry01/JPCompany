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

puts 'Cadastrando CATEGORIAS...[OK]'