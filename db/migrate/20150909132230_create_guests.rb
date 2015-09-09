class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :password
      t.string :name
      t.string :rspv

      t.timestamps null: false
    end
  end
end
