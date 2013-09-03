class CreateFormations < ActiveRecord::Migration
  def up
    create_table :formations do |t|
      t.integer :numero
      t.text :titre
      t.text :niveau
      t.text :lieux
      t.text :region
    end
  end

  def down
    drop_table :formations
  end
end
