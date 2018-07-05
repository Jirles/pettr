class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name, null: false
      t.string :breed
      t.string :age
      t.string :city
      t.float :user_rating, default: 5.00
      t.integer :owner_id, null: false
      t.string :bio

      t.timestamps
    end
  end
end
