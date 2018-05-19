class CreateDriverexams < ActiveRecord::Migration[5.0]
  def change
    create_table :driverexams do |t|
      t.string :subject, default:""
      t.string :chapter, default:""
      t.string :q_type, default:""
      t.string :question, default:""
      t.string :option1, default:""
      t.string :option2, default:""
      t.string :option3, default:""
      t.string :option4, default:""
      t.string :pic, default:""
      t.string :answer, default:""
      t.text :explain, default:""
      t.string :chapter_no, default:""

      t.timestamps
    end
  end
end
