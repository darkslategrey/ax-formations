class AddColumnCateg < ActiveRecord::Migration

  def up
    add_column :formations, :categorie, :string
  end

  def down
    drop_column :formations, :categorie
  end
end

