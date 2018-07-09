module DogsHelper

  def dog_show_rating_display
    Proc.new { |rating| "#{rating} stars" }
  end

  def dog_pet_by_user_display
    Proc.new { | petting | "#{petting.name} was pet by #{petting.user.full_name}!" }
  end
end
