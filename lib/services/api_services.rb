require 'rest-client'

module ApiServices
  class ConsumeApi
    attr_accessor :base
    
    def initialize
        @baseUrl = "https://pokeapi.co/api/v2/"
    end

    def get_json_response url:nil 
      puts "Consulting... #{@baseUrl}#{url}"
      json_response = JSON.parse(RestClient.get "#{@baseUrl}#{url}")
      json_response
    end

    def get_initial_information     
      pokemons = (get_json_response url: "pokemon?limit=3")["results"]
      pokemons.map do |pok| 
      pok_info =  (get_pokemon_by_name name: pok['name'])      
        pok["order"] = pok_info["order"]
        pok["base_experience"] = pok_info["base_experience"]
        pok["height"] = pok_info["height"]
        pok["weight"] = pok_info["weight"]
        pok["img_url"] = pok_info["sprites"]["front_default"]
        pok["is_default"] = pok_info["is_default"]
        pok["pokemon_abilities"] = pok_info["abilities"].each{ |ability| ability["ability"]["is_main_series"] = (get_ability_by_name name: ability.dig("ability", "name")).dig("is_main_series")}
        pok["pokemon_types"] = pok_info["types"]
      end
      pokemons
    end

    def get_all_pokemons
      #pokemons = RestClient.get "#{@baseUrl}pokemon?limit=50&offset=3"
      pokemons = (get_json_response url: "pokemon?limit=50&offset=3")["results"]
      pokemons
    end 

    def get_pokemon_by_name name:nil 
      #pokemon = RestClient.get "#{@baseUrl}pokemon/#{name}"
      pokemon = (get_json_response url: "pokemon/#{name}")#["results"]
      pokemon
    end

    def get_all_abilities
      abilities = (get_json_response url: "ability?limit=327")["results"]
      abilities
    end

    def get_ability_by_name name:nil       
      ability = get_json_response url: "ability/#{name}"
      ability
    end

    def get_all_types
      abilities = (get_json_response url: "type")["results"]
      abilities
    end

    def get_type_by_name name:nil
      type = get_json_response url: "type/#{name}"
      type
    end

  end
end
