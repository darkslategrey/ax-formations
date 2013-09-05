class AddColumnLogo < ActiveRecord::Migration

  def up
    add_column :formations, :logo, :string
    add_column :formations, :tel, :string
    add_column :formations, :fax, :string
    add_column :formations, :email, :string
  end

  def down
    drop_column :formations, :logo
    drop_column :formations, :tel
    drop_column :formations, :fax
    drop_column :formations, :email
  end
end
