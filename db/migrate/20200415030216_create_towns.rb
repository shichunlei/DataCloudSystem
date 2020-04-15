class CreateTowns < ActiveRecord::Migration[5.0]
  def change
    create_table :towns do |t|
      t.string :name,     default: ""
      t.string :no,     default: ""
      t.references :county, foreign_key: true

      t.timestamps
    end
  end
end
