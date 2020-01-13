class RenameSaveColumnRecord2017 < ActiveRecord::Migration[4.2]
  def change
  	rename_column :player_record2017s, :save, :save_point
  end
end
