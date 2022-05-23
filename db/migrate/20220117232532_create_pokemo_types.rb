class CreatePokemoTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_types do |t|
      t.integer :pokemon_id
      t.integer :type_id
      t.timestamps
    end
    add_index('pokemon_types', ['pokemon_id','type_id'])
  end
end

