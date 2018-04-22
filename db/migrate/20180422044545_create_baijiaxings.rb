class CreateBaijiaxings < ActiveRecord::Migration[5.0]
  def change
    create_table :baijiaxings do |t|
      t.string :name, default:""
      t.string :author, default:""
      t.text :source, default:""
      t.text :celebrity, default:""
      t.text :distributing, default:""

      t.timestamps
    end
  end
end
