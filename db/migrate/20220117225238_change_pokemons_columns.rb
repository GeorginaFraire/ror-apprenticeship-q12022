class ChangePokemonsColumns < ActiveRecord::Migration[6.1]
  def up
    change_column(:pokemons, :name, :string, limit: 255, null:false)
    change_column(:pokemons, :order, :integer, null:false)
    change_column(:pokemons, :base_expirence, :integer, null:false)
    change_column(:pokemons, :heigth, :integer, null:false)
    change_column(:pokemons, :weight, :integer, null:false)  
  end

  def down
    change_column(:pokemons, :name, :string)
    change_column(:pokemons, :order, :integer)
    change_column(:pokemons, :base_expirence, :integer)
    change_column(:pokemons, :heigth, :integer)
    change_column(:pokemons, :weight, :integer)
  end
end
