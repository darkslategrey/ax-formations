class AddDoliId < ActiveRecord::Migration

  def up
    add_column :formations, :id_doli, :integer
  end

  def down
    drop_column :formations, :id_doli
  end
end
