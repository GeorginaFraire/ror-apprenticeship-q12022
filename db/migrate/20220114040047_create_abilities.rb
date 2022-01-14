class CreateAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :abilities do |t|
      t.string :name
      t.string :is_main_series
      t.string :bool

      t.timestamps
    end
  end
end
