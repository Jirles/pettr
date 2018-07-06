class DropOwnerIdColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :dogs, :owner_id, :integer
  end
end
