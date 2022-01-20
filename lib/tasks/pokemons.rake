require_relative '../services/api_services'
include ApiServices

namespace :pokemon do 
    task insert_pokemons: :environment do
    begin
      api =  ApiServices::ConsumeApi.new 
      response = api.get_all_pokemons 
      raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error')
      response.dig('response').each do |pokemon|
        #validar si el pokemon ya existe en la base da datos
        db_pokemon = Pokemon.find_by_name(pokemon["name"])

        if db_pokemon.nil? 
          #find the informations about the pokemons
          response =  api.get_pokemon_by_name name:pokemon["name"]
          api_pokemon = response["response"]   
          #puts api_pokemon
          puts Pokemon.create!({name: api_pokemon["name"], order: api_pokemon["order"], base_expirence: api_pokemon["base_experience"], heigth: api_pokemon["height"], weight: api_pokemon["weight"], img_url: api_pokemon["sprites"]["other"]["official-artwork"]["front_default"], is_default: api_pokemon["is_default"] })
          #p "name = #{api_pokemon["name"]} order = #{api_pokemon["order"]} base_expirence = #{api_pokemon["base_experience"]} heigth = #{api_pokemon["height"]} weight = #{api_pokemon["weight"]} url_img = #{api_pokemon["sprites"]["front_default"]}" 
        end 
      end
    rescue StandardError => e
      puts response.dig('errors')
    end
    end
end
