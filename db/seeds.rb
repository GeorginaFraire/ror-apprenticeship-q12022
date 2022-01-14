# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#using create 
Pokemon.create({name: 'Pikachu', order: 35, base_expirence: 112, heigth:4, weight: 60, img_url: 'https://github.com/PokeAPI/sprites/blob/master/sprites/pokemon/other/dream-world/25.svg' })
Pokemon.create({name: 'Mewtwo', order: 230, base_expirence: 306, heigth:20, weight: 60, img_url: 'https://github.com/PokeAPI/sprites/blob/master/sprites/pokemon/other/dream-world/150.svg'})
#using instance
pokemon = Pokemon.new
pokemon.name = 'Charizard'
pokemon.order = 35
pokemon.base_expirence = 240
pokemon.heigth = 7
pokemon.weight = 905
pokemon.img_url = 'https://github.com/PokeAPI/sprites/blob/master/sprites/pokemon/other/dream-world/6.svg'
pokemon.save
