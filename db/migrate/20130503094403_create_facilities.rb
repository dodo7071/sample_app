class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.integer :location_id
      t.string :title
      t.string :info
      t.string :services
      t.string :adress
      t.string :web_page
      t.string :email
      t.string :gps

      t.timestamps
    end
  end
end
