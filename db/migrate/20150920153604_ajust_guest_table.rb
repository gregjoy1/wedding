class AjustGuestTable < ActiveRecord::Migration
  def up
    remove_column :guests, :password
    add_reference :guests, :login, index: true
  end

  def down
    add_column :guests, :password
    remove_reference :guests, :login, index: true
  end
end
