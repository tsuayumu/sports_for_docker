class AddColumnDreamPlayer < ActiveRecord::Migration[4.2]
  def change
  	add_column :dream_players, :steal, :integer, null: false, default: 0
  end
end
