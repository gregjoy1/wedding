class AddNoteFieldToGuest < ActiveRecord::Migration
  def up
    add_column :guests, :note, :text
  end

  def down
    remove_column :guests, :note
  end
end
