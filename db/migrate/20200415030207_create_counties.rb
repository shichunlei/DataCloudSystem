class CreateCounties < ActiveRecord::Migration[5.0]
  def change
    create_table :counties do |t|
      t.string :name,     default: ""
      t.string :no,     default: ""
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
