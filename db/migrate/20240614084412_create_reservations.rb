class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :person_num
      t.date :reservation_start_date
      t.date :reservation_end_date

      t.timestamps
    end
  end
end
