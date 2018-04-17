class CreateTodayhistories < ActiveRecord::Migration[5.0]
  def change
    create_table :todayhistories do |t|
      t.string :name, default:""
      t.integer :year, default:1
      t.integer :month, default:1
      t.integer :day, default:1
      t.string :image, default:""
      t.text :content, default:""

      t.timestamps
    end
  end
end
