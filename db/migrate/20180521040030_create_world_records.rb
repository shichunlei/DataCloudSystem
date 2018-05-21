class CreateWorldRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :world_records do |t|
      t.string :name, default:""
      t.string :category, default:""
      t.string :pic_url, default:""
      t.text :pic_all_url, default:""
      t.text :content, default:""

      t.timestamps
    end
  end
end
