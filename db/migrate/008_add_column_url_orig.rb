class AddColumnUrlOrig < ActiveRecord::Migration

  def up
    add_column :formations, :url_orig, :string
  end

  def down
    drop_column :formations, :url_orig
  end
end
