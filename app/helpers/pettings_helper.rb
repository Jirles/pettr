module PettingsHelper

  def user_dog_petting_display(petting)
    "#{petting.user.full_name} pet #{petting.dog.name}!"
  end

  def petting_rating_display(petting)
    "#{petting.pet_rating}/5 would do it again"
  end
end
