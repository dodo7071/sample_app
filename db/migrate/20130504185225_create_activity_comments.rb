class CreateActivityComments < ActiveRecord::Migration
  def change
    create_table :activity_comments do |t|
      t.integer :user_id
      t.integer :activity_id
      t.string :text

      t.timestamps
    end
  end
end
