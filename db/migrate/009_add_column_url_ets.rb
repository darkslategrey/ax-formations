class AddColumnUrlEts < ActiveRecord::Migration

  def up
    add_column :formations, :url_ets, :string
  end

  def down
    drop_column :formations, :url_ets
  end
end
