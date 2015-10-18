class AddGuestMenuItemsTable < ActiveRecord::Migration
  def up
    create_table :guest_menu_items do |t|
      t.integer :guest_id
      t.integer :menu_item_id
    end
  end

  def down
    drop_table :guest_menu_items
  end
end
