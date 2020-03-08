class CreateUserRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_rooms do |t|
      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
