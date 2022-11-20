class AddReportIdToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :report_id, :integer
  end
end
