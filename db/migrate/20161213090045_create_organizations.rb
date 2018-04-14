class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.references :organization, index: true,foreign_key: true

      t.timestamps
    end
  end
end
