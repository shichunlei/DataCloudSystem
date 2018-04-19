class CreateHuanglis < ActiveRecord::Migration[5.0]
  def change
    create_table :huanglis do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :yangli, default:""
      t.string :nongli, default:""
      t.string :star, default:""
      t.string :taishen, default:""
      t.string :wuxing, default:""
      t.string :chong, default:""
      t.string :sha, default:""
      t.string :shengxiao, default:""
      t.string :jiri, default:""
      t.string :zhiri, default:""
      t.string :xiongshen, default:""
      t.string :jishenyiqu, default:""
      t.string :caishen, default:""
      t.string :xishen, default:""
      t.string :fushen, default:""
      t.string :suici, default:""
      t.string :yi, default:""
      t.string :ji, default:""
      t.string :eweek, default:""
      t.string :emonth, default:""
      t.string :week, default:""

      t.timestamps
    end
  end
end
