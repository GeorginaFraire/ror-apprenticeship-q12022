class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :order
      t.integer :base_expirence
      t.integer :heigth
      t.integer :weight
      t.string :img_url

      t.timestamps
    end
  end
end
