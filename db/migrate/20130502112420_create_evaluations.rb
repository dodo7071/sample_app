class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :user_id
      t.integer :activity_id
      t.integer :value
      t.string :note

      t.timestamps
    end
  end
end
