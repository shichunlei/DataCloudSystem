class CreateLaws < ActiveRecord::Migration[5.0]
  def change
    create_table :laws do |t|
      t.string :name, default:""
      t.string :pub_department, default:""
      t.string :reference_num, default:""
      t.date :pub_date
      t.date :exec_date
      t.string :pub_timeliness, default:""
      t.string :effectiveness_level, default:""
      t.string :regcategory, default:""
      t.text :content, default:""

      t.timestamps
    end
  end
end
