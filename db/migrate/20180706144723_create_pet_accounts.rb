class CreatePetAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_accounts do |t|
      t.integer :user_id
      t.integer :dog_id

      t.timestamps
    end
  end
end
