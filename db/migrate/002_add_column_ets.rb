class AddColumnEts < ActiveRecord::Migration

  def up
    add_column :formations, :ets, :string
    add_column :formations, :cp, :string
    add_column :formations, :ville, :string
    add_column :formations, :url, :string
    add_column :formations, :addresse, :string
    rename_column :formations, :titre, :intitule
  end

  def down
    drop_column :formations, :ets
    drop_column :formations, :cp
    drop_column :formations, :ville
    rename_column :formations, :intitule, :titre
  end
end
