class CreatePettings < ActiveRecord::Migration[5.2]
  def change
    create_table :pettings do |t|
      t.integer :user_id
      t.integer :dog_id
      t.string :name
      t.string :breed
      t.string :location
      t.integer :petting_rating
      t.string :description

      t.timestamps
    end
  end
end
