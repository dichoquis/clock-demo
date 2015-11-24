class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true, limit: 30
      t.string :email, null: false, unique: true, limit: 30
      t.string :password_digest, null: true
      t.string :first_name, null: false, limit: 30
      t.string :last_name, null: false, limit: 30
      t.string :phone_number, limit: 20
      t.string :title, limit: 30
      t.string :timezone, limit: 50
      t.integer :role, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.datetime :archived_date

      t.timestamps
    end
  end
end
