class CreateGuests < ActiveRecord::Migration
  def up
    create_table :guests do |t|
      t.string :password
      t.string :name
      t.string :rspv

      t.timestamps null: false
    end

    def down
      drop_table :guests
    end
  end
end
