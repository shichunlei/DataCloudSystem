class CreateMonthFortunes < ActiveRecord::Migration[5.0]
  def change
    create_table :month_fortunes do |t|
      t.string :mdate, default:""
      t.text :summary, default:""
      t.text :money, default:""
      t.text :career, default:""
      t.text :love, default:""
      t.text :health, default:""
      t.references :astro, foreign_key: true

      t.timestamps
    end
  end
end
