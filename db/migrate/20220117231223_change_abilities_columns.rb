class ChangeAbilitiesColumns < ActiveRecord::Migration[6.1]
  def up
    change_column(:abilities, :name, :string, limit: 255, null:false)
  end

  def down
    change_column(:abilities, :name, :string)
  end
end
