class AddColumnPlayer < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :year, :integer, default: 2018
  end
end
