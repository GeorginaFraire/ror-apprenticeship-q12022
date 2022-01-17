class AddColumnPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :is_default, :boolean
  end
end
