class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|

    	t.string :name
      t.string :status
      t.datetime :logged_time

      t.timestamps null: false
    end
  end
end
