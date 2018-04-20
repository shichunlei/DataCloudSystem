class CreateAstros < ActiveRecord::Migration[5.0]
  def change
    create_table :astros do |t|
      t.string :name, default:""
      t.string :pic, default:""
      t.string :start_date, default:""
      t.string :end_date, default:""

      t.timestamps
    end
  end
end
