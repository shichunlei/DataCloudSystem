class CreateWeekFortunes < ActiveRecord::Migration[5.0]
  def change
    create_table :week_fortunes do |t|
      t.date :start_date
      t.date :end_date
      t.text :money, default:""
      t.text :career, default:""
      t.text :love, default:""
      t.text :health, default:""
      t.text :job, default:""
      t.references :astro, foreign_key: true

      t.timestamps
    end
  end
end
