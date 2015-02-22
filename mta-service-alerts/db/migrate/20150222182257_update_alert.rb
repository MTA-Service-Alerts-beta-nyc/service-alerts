class UpdateAlert < ActiveRecord::Migration
  def change
    remove_column :alerts, :logged_time
    add_column :alerts, :start_time, :datetime
    add_column :alerts, :end_time, :datetime
    add_column :alerts, :active, :boolean
    add_column :alerts, :text, :text
  end
end
