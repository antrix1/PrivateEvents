class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :event_date
      t.time :event_time
      t.text :description
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
