class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :user_blocked_times, :type, :block_type
  end
end
