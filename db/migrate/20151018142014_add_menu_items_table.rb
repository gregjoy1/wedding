class AddMenuItemsTable < ActiveRecord::Migration
  def up
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.string :labels
    end
  end

  def down
    drop_table :menu_items
  end
end
