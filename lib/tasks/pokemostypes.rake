require_relative '../services/api_services'
include ApiServices

namespace :pokemon_types do 
    task insert_pokemon_types: :environment do
     #begin
       api =  ApiServices::ConsumeApi.new 
       api.get_all_types.each do |pokemon_type|
        
        #validar si el pokemon ya existe en la base da datos
        db_pokemon_type = Type.find_by_name(pokemon_type["name"])
        if db_pokemon_type.nil? 
          Type.create({name: pokemon_type["name"]})
        end 
      end
    end
    
  end