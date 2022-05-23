class Type < ApplicationRecord
  
  validates :name, :presence => true, :length => {:maximum => 255}

  scope :name_sort, -> {order(:name)}

  has_many :pokemon_types
  has_many :pokemons, :through => :pokemon_types
end
