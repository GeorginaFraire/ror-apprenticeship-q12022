class Pokemon < ApplicationRecord

  validates :name, :presence => true,  :length => {:maximum => 255}
  validates :order, :presence => true, :numericality => true
  validates :base_expirence, :presence => true, :numericality => true
  validates :heigth, :presence => true, :numericality => true
  validates :weight, :presence => true, :numericality => true

  scope :name_sort, -> {order(:name)}

  has_many :ability_pokemons
  has_many :abilities, :through => :ability_pokemons

  has_many :pokemon_types
  has_many :types, :through => :pokemon_types
  
end
