class AddOrganizationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :organization, index: true,foreign_key: true
  end
end
