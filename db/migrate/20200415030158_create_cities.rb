class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name,     default: ""
      t.string :no,     default: ""
      t.references :province, foreign_key: true

      t.timestamps
    end
  end
end
