class Ability < ApplicationRecord

  validates :name, :presence => true, :length => {:maximum => 255}
  
  scope :name_sort, ->{ order(:name) }
  
  has_many :ability_pokemons
  has_many :pokemons, :through => :ability_pokemons
end
