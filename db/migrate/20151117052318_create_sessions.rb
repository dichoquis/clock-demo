class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :ip_address
      t.datetime :last_session_date
    end
    add_index :sessions, :user_id
  end
end
