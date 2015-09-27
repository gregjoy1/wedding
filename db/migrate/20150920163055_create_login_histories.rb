class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
      t.string :user_agent
      t.datetime :logged_in
      t.datetime :last_activity
      t.belongs_to :login, index:true

      t.timestamps null: false
    end
  end
end
