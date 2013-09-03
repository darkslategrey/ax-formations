class AddColumnDest < ActiveRecord::Migration

  def up
    add_column :formations, :dest, :string
  end

  def down
    drop_column :formations, :dest
  end
end

