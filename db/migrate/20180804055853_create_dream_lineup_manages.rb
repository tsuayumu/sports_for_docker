class CreateDreamLineupManages < ActiveRecord::Migration[4.2]
  def change
    create_table :dream_lineup_manages do |t|
    	t.string :comment, default: ""
      t.timestamps
    end
  end
end
