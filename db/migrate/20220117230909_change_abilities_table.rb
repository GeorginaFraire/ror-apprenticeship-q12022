class ChangeAbilitiesTable < ActiveRecord::Migration[6.1]
  def up
    change_table :abilities do |t|
      t.remove :is_main_series , :bool, :updated_at, :created_at
      t.boolean :is_main_series, null:false
      t.timestamps
    end
  end

  def down
    change_table :abilities do |t|
      t.remove :is_main_series
      t.string :is_main_series
      t.string :bool
    end
  end
end
