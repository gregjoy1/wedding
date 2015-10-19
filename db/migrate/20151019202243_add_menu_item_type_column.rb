class AddMenuItemTypeColumn < ActiveRecord::Migration
  def up
    add_column :menu_items, :meal_type, :string
  end

  def down
    remove_column :menu_items, :meal_type
  end
end
