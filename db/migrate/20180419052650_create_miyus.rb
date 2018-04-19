class CreateMiyus < ActiveRecord::Migration[5.0]
  def change
    create_table :miyus do |t|
      t.string :content, default:""
      t.string :answer, default:""
      t.references :miyu_classify, foreign_key: true

      t.timestamps
    end
  end
end
