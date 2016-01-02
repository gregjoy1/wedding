class AddAdminToLogin < ActiveRecord::Migration
  def up
    add_column :logins, :is_admin, :boolean, :default => false
  end

  def down
    remove_column :logins, :is_admin
  end
end
