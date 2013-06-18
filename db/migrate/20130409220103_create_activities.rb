class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :activity_type_id
      t.date :beg_date
      t.date :end_date
      t.time :beg_time
      t.time :end_time
      t.string :note

      t.timestamps
    end
	add_index :activities, [:user_id, :created_at]
  end
end
