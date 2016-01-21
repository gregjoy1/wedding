class AddIsEveningGuestToLogin < ActiveRecord::Migration
  def up
    add_column :logins, :is_evening_guest, :boolean, :default => false
  end

  def down
    remove_column :logins, :is_evening_guest
  end
end
