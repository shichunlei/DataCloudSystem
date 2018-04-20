class CreateTomorrowFortunes < ActiveRecord::Migration[5.0]
  def change
    create_table :tomorrow_fortunes do |t|
      t.date :tdate
      t.integer :love
      t.integer :health
      t.integer :career
      t.string :color, default:""
      t.string :star, default:""
      t.integer :number
      t.integer :summary
      t.text :presummary, default:""
      t.integer :money
      t.references :astro, foreign_key: true

      t.timestamps
    end
  end
end
