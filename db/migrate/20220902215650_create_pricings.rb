class CreatePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :pricings do |t|
      t.integer :booking_id
      t.integer :user_id
      t.integer :hours_rq
      t.integer :total_price

      t.timestamps
    end
  end
end
