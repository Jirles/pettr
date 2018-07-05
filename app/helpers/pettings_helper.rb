module PettingsHelper

  def user_dog_petting_display(petting)
    "#{petting.user.full_name} pet #{petting.name}!"
  end

  def petting_rating_display(petting)
    "#{petting.pet_rating}/5.0 would do it again"
  end

  def edit_delete_options
  end
end
