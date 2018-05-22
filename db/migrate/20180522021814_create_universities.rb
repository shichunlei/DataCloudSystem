class CreateUniversities < ActiveRecord::Migration[5.0]
  def change
    create_table :universities do |t|
      t.string :universityid, default:""
      t.string :name, default:""
      t.string :f211, default:""
      t.string :f985, default:""
      t.string :area, default:""
      t.string :address, default:""
      t.string :phone, default:""
      t.string :email, default:""
      t.string :level, default:""
      t.string :membership, default:""
      t.string :nature, default:""
      t.string :schoolid, default:""
      t.string :schooltype, default:""
      t.string :website, default:""
      t.text :shoufei, default:""
      t.text :intro, default:""

      t.timestamps
    end
  end
end
