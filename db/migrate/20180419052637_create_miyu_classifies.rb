class CreateMiyuClassifies < ActiveRecord::Migration[5.0]
  def change
    create_table :miyu_classifies do |t|
      t.string :name, default:""

      t.timestamps
    end
  end
end
