class CreateVillages < ActiveRecord::Migration[5.0]
  def change
    create_table :villages do |t|
      t.string :name,     default: ""
      t.string :no,       default: ""
      t.string :code_no,  default: ""
      t.references :town, foreign_key: true

      t.timestamps
    end
  end
end
