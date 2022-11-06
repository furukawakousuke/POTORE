class RemoveRemotePostImageIdFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :name, :integer
  end
end
