class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :city
      t.integer :user_rating
      t.integer :owner_id
      t.string :bio
    end
  end
end
