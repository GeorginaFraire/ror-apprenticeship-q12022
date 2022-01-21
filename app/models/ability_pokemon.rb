class AbilityPokemon < ApplicationRecord
    validates :ability_id, :presence => true, :numericality => true, :uniqueness => { scope: :pokemon_id }
    
    belongs_to :ability
    belongs_to :pokemon
end
