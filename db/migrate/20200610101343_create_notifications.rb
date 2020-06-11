class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :notify_type,     default: ""
      t.references :user, foreign_key: true
      t.string :from_user,     default: ""
      t.string :from_user_name,     default: ""
      t.string :status,     default: ""
      t.string :reason,     default: ""

      t.timestamps
    end
  end
end
