class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :action, default:""
      t.string :subject, default:""
      t.string :description, default:""

      t.timestamps
    end
  end
end
