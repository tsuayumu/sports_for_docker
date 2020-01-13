class AddColumnLeagues < ActiveRecord::Migration[4.2]
  def change
  	add_column :leagues, :status, :integer, null: false, default: 0
  end
end
