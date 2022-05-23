require 'rest-client'

module ApiServices
  class Poke_api
    attr_accessor :base
    
    def initialize
        @baseUrl = "https://pokeapi.co/api/v2/"
    end

    def get_json_response url:nil 
      json_response = {}
     begin 
        puts "#{@baseUrl}#{url}"
        json_response["response"] = JSON.parse(RestClient.get "#{@baseUrl}#{url}")   
        json_response
     rescue SocketError => e
      p "Error: Cannot find the url #{@baseUrl}#{url}"
      raise(e)
     rescue RestClient::NotFound => e
      raise (e)
     end
    end
  
    def get_initial_information      
      response = (get_json_response url: "pokemon?limit=3")
        pokemons = response.dig("response", "results")
        pokemons.map do |pok| 
        pok_info =  (get_pokemon_by_name name: pok['name']).dig('response')
          pok["order"] = pok_info["order"]
          pok["base_experience"] = pok_info["base_experience"]
          pok["height"] = pok_info["height"]
          pok["weight"] = pok_info["weight"]
          pok["img_url"] = pok_info["sprites"]["other"]["official-artwork"]["front_default"]
          pok["is_default"] = pok_info["is_default"]
          pok["pokemon_abilities"] = pok_info["abilities"].each{ |ability| ability["ability"]["is_main_series"] = (get_ability_by_name name: ability.dig("ability", "name")).dig("response","is_main_series")}
          pok["pokemon_types"] = pok_info["types"]
        end
        response["response"] = pokemons
        response
    end

    def get_all_pokemons limit: 10
      response = (get_json_response url: "pokemon?limit=#{limit}&offset=3")
      response["response"] = response.dig('response', 'results')
      response
    end 

    def get_pokemon_by_name name:nil 
      begin 
        raise StandardError.new "name cannot be blank" if (name.nil? || name.empty?)
        response = (get_json_response url: "pokemon/#{name}")
        response["response"] = (get_json_response url: "pokemon/#{name}")["response"]
        response
      rescue StandardError => e
        raise(e)
      end
    end

    def get_all_abilities
        response = (get_json_response url: "ability?limit=327")
        response["response"] = response.dig('response', 'results')      
        response 
    end

    def get_ability_by_name name:nil      
      begin 
        raise StandardError.new "name cannot be blank" if (name.nil? || name.empty?)
        response = (get_json_response url: "ability/#{name}")
        response
       rescue StandardError => e
         raise(e)
       end
    end

    def get_all_types
      begin
        response = (get_json_response url: "type")
        raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error')
        response["response"] = response.dig('response', 'results')
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>  e.class})
        response
      end 
    end
  end
end
