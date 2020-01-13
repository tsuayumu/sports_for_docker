class AddCulomnRecord2017 < ActiveRecord::Migration[4.2]
  def change
  	add_column :player_record2017s, :era, :decimal, precision: 4, scale: 2, null: false, default: 0
  end
end
