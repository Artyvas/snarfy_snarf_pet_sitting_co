class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :animal_first
      t.string :animal_last
      t.string :animal_type
      t.integer :hours_rq
      t.datetime :date_of_service

      t.timestamps
    end
  end
end
