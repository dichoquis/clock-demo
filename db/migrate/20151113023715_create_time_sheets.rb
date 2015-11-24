class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :total_minutes
      t.text :work_report
      t.datetime :report_date
      t.string :ip_address, limit: 50

      t.references :user, index: true, foreign_key: true
    end
  end
end
