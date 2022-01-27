# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative '../lib/services/api_services'
include ApiServices

api_service = ApiServices::Poke_api.new
response = api_service.get_initial_information
response.dig('response').each do |pokemon_api|
    pokemon_new = Pokemon.create( {name: pokemon_api['name'], order: pokemon_api["order"], 
        base_expirence: pokemon_api["base_experience"], heigth: pokemon_api["height"], 
        weight: pokemon_api["height"], img_url: "#{pokemon_api['img_url']}", is_default:["is_default"]})
    pokemon_api["pokemon_abilities"].each do |ability_api|
    
      ability_new = Ability.find_by_name(ability_api.dig("ability", "name"))
      if ability_new.nil?
        ability_new = Ability.create({ name: ability_api.dig("ability", "name"), is_main_series:ability_api.dig("ability","is_main_series")})
      end
      ability_pokemons = AbilityPokemon.create(ability: ability_new, pokemon: pokemon_new) 
    end

    pokemon_api["pokemon_types"].each do |type_api|
      type_new = Type.find_by_name(type_api.dig('type', 'name'))
      if type_new.nil?
        type_new = Type.create({name: type_api.dig('type', 'name')})
      end
      pokemon_types = PokemonType.create(pokemon: pokemon_new, type: type_new)
    end
end
