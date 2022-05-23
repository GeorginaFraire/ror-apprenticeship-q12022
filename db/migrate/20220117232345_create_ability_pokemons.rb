class CreateAbilityPokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :ability_pokemons do |t|
      t.integer :ability_id
      t.integer :pokemon_id 

      t.timestamps
    end
    add_index('ability_pokemons',['ability_id', 'pokemon_id'])
  end
end
