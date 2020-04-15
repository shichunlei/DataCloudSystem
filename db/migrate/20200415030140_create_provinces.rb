class CreateProvinces < ActiveRecord::Migration[5.0]
  def change
    create_table :provinces do |t|
      t.string :name,     default: ""
      t.string :no,       default: ""
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
