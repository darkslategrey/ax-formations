class AddColumnAtcId < ActiveRecord::Migration

  def up
    add_column :formations, :id_atc, :integer
  end

  def down
    drop_column :formations, :id_atc
  end
end
