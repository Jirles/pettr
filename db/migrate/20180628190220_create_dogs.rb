class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.string :city
      t.string :bio
      t.integer :user_id
      t.integer :user_rating, default: 5
      t.string :instagram

      t.timestamps
    end
  end
end
