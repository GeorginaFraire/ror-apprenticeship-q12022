class PokemonType < ApplicationRecord
    validates :type_id, uniqueness: { scope: :pokemon_id }
    
    belongs_to :pokemon
    belongs_to :type
end
