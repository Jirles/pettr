class ChangeUserRatingColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :dogs, :user_rating, from: nil, to: 5
  end
end
