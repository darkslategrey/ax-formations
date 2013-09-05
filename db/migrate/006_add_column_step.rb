class AddColumnStep < ActiveRecord::Migration

  def up
    add_column :formations, :step, :string
  end

  def down
    drop_column :formations, :step
  end
end
