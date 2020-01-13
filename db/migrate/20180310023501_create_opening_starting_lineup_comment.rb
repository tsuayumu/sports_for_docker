class CreateOpeningStartingLineupComment < ActiveRecord::Migration[4.2]
  def change
    create_table :opening_starting_lineup_comments do |t|
    	t.integer :opening_starting_lineup, index: { name: 'index_opening_starting_lineup_id' }, foreign_key: true, null: false
    	t.integer :user, index: { name: 'index_opening_starting_user_id' }, foreign_key: true, null: true
    	t.string :comment, null: false
      t.timestamps
    end
  end
end
