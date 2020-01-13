class CreateOpeningStartingLineups < ActiveRecord::Migration[4.2]
  def change
    create_table :opening_starting_lineups do |t|
      t.integer :user, index: true, foreign_key: true, null: true
      t.integer :team, index: true, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :one, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :two, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :three, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :four, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :five, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :six, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :seven, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :eight, index: true, foreign_key: { to_table: :player }, null: false
      t.integer :nine, index: true, foreign_key: { to_table: :player }, null: false
      t.string :comment, null: true
      t.timestamps
    end
  end
end
