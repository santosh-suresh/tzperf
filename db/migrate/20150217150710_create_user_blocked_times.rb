class CreateUserBlockedTimes < ActiveRecord::Migration
  def change
    create_table :user_blocked_times do |t|
      t.string :type
      t.tstzrange :blocked_time
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_blocked_times, :users
  end
end
