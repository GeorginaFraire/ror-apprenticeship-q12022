require_relative '../services/api_services'
include ApiServices

namespace :abilities do
    task insert_abilities: :environment do
        api = ApiServices::ConsumeApi.new 
        api.get_all_abilities.each do |ability|
          #valirar si la abilidad ya existe en la base de datos 
          db_ability = Ability.find_by_name(ability["name"])
          if db_ability.nil?
            api_ability = api.get_ability_by_name name: ability["name"]
            #p api_ability["is_main_series"] and p api_ability["name"]
            Ability.create({ name: api_ability["name"], is_main_series:api_ability["is_main_series"]})
          end
        end
    end 
end
