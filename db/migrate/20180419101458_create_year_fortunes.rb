class CreateYearFortunes < ActiveRecord::Migration[5.0]
  def change
    create_table :year_fortunes do |t|
      t.integer :year
      t.text :summary, default:""
      t.text :money, default:""
      t.text :career, default:""
      t.text :love, default:""
      t.references :astro, foreign_key: true

      t.timestamps
    end
  end
end
