class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description, null: false
      t.integer :priority, null: false
      t.datetime :expiration_date

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
