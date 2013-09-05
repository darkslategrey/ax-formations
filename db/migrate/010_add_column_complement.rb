class AddColumnComplement < ActiveRecord::Migration

  def up
    add_column :formations, :objectif, :text
    add_column :formations, :contenu, :text
  end

  def down
    drop_column :formations, :objectif
    drop_column :formations, :contenu
  end
end
