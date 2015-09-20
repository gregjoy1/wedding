class CreateLogins < ActiveRecord::Migration
  def up
    create_table :logins do |t|
      t.string :name
      t.string :password

      t.timestamps null: false
    end

    def down
      drop_table :logins
    end
  end
end
