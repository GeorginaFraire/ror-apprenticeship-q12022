require_relative '../services/api_services'
include ApiServices

namespace :pokemon do 
  task insert_pokemons: :environment do
    api =  ApiServices::Poke_api.new 
    response = api.get_all_pokemons 
    response.dig('response').each do |pokemon|
      #validate if the pokemon exists
      db_pokemon = Pokemon.find_by_name(pokemon["name"])

      if db_pokemon.nil? 
        #find the information about the pokemons
        response =  api.get_pokemon_by_name name:pokemon["name"]
        api_pokemon = response["response"]   
        Pokemon.create!({name: api_pokemon["name"], order: api_pokemon["order"], base_expirence: api_pokemon["base_experience"], heigth: api_pokemon["height"], weight: api_pokemon["weight"], img_url: api_pokemon["sprites"]["other"]["official-artwork"]["front_default"], is_default: api_pokemon["is_default"] })
        #p "name = #{api_pokemon["name"]} order = #{api_pokemon["order"]} base_expirence = #{api_pokemon["base_experience"]} heigth = #{api_pokemon["height"]} weight = #{api_pokemon["weight"]} url_img = #{api_pokemon["sprites"]["front_default"]}" 
      end 
    end
  end
end
