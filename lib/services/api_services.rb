require 'rest-client'

module ApiServices
  class ConsumeApi
    attr_accessor :base
    
    def initialize
        @baseUrl = "https://pokeapi.co/api/v2/"
    end

    def get_json_response url:nil 
      json_response = {"errors" => {"has_error"=> false, "message"=> '', "class"=>''}, "response" => nil}
     begin 
        puts "Consulting... #{@baseUrl}#{url}"
        json_response["response"] = JSON.parse(RestClient.get "#{@baseUrl}#{url}")   
        json_response
     rescue SocketError => e
       json_response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>e.class})
       json_response
     rescue RestClient::NotFound => e
        json_response["errors"] = {"has_error"=> true, "message"=> e.message, "class"=>e.class} 
        json_response
     end
    end
  
    def get_initial_information     
      begin
      response = (get_json_response url: "pokemon?limit=3") 
      unless (response.dig('errors','has_error'))
        pokemons = response.dig("response", "results")
        pokemons.map do |pok| 
        pok_info =  (get_pokemon_by_name name: pok['name']).dig('response')
          pok["order"] = pok_info["order"]
          pok["base_experience"] = pok_info["base_experience"]
          pok["height"] = pok_info["height"]
          pok["weight"] = pok_info["weight"]
          pok["img_url"] = pok_info["sprites"]["front_default"]
          pok["is_default"] = pok_info["is_default"]
          pok["pokemon_abilities"] = pok_info["abilities"].each{ |ability| ability["ability"]["is_main_series"] = (get_ability_by_name name: ability.dig("ability", "name")).dig("response","is_main_series")}
          pok["pokemon_types"] = pok_info["types"]
        end
        response["response"] = pokemons
        response
      end
      raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error') 
      
      rescue NoMethodError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>e.class})
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>e.class})
        response
      end 
    end

    def get_all_pokemons
      begin
        response = (get_json_response url: "pokemon?limit=50&offset=3")
        raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error')
        response["response"] = response.dig('response', 'results')
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>  e.class})
        response
      end 
    end 

    def get_pokemon_by_name name:nil 
      #pokemon = RestClient.get "#{@baseUrl}pokemon/#{name}"
      begin 
        raise StandardError.new "name cannot be blank" if (name.nil? || name.empty?)
        response = (get_json_response url: "pokemon/#{name}")
        raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error')
        response["response"] = (get_json_response url: "pokemon/#{name}")["response"]
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>  e.class})
        response
      end
    end

    def get_all_abilities
      #abilities = (get_json_response url: "ability?limit=327")["results"]
      #abilities
      begin
        response = (get_json_response url: "ability?limit=327")
        raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error')
        response["response"] = response.dig('response', 'results')
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>  e.class})
        response
      end 
    end

    def get_ability_by_name name:nil      
      begin 
        raise StandardError.new "name cannot be blank" if (name.nil? || name.empty?)
        response = (get_json_response url: "ability/#{name}")
        raise StandardError.new response.dig('errors','message') if response.dig('errors', 'has_error') 
        response
      rescue StandardError => e
        response.store("errors", {"has_error"=> true, "message"=> e.message, "class"=>e.class})
        response
      end
    end

    def get_all_types
      #types = (get_json_response url: "type")["results"]
      #types
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

    def get_type_by_name name:nil
      type = get_json_response url: "type/#{name}"
      type
    end

  end
end
