class RemoveColumnLineupManage < ActiveRecord::Migration[4.2]
	def up
    remove_column :lineup_manages, :one_id
    remove_column :lineup_manages, :two_id
    remove_column :lineup_manages, :three_id
    remove_column :lineup_manages, :four_id
    remove_column :lineup_manages, :five_id
    remove_column :lineup_manages, :six_id
    remove_column :lineup_manages, :seven_id
    remove_column :lineup_manages, :eight_id
    remove_column :lineup_manages, :nine_id
  end

  def down
  	add_column :lineup_manages, :one_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :two_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :three_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :four_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :five_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :six_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :seven_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :eight_id	, index: true, foreign_key: { to_table: :player }, null: false
    add_column :lineup_manages, :nine_id	, index: true, foreign_key: { to_table: :player }, null: false
  end
end
