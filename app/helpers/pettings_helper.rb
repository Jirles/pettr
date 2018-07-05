module PettingsHelper

  def user_dog_petting_display(petting)
    "#{petting.user.full_name} pet #{petting.name}!"
  end

  def petting_rating_display(petting)
    "#{petting.pet_rating}/5.0 would do it again"
  end

  def edit_delete_options(petting, current_user)
    if petting.user == current_user
      link_to "Edit", edit_petting_path(petting)
      link_to "Delete", petting, method: :delete, data: { confirm: "Are you sure you want to delete this record?" }
    end
  end

  def display_flash_notices
    if flash[:notice]
      content_tag :div, flash[:notice], class: 'flash-notice-div'
    end
  end
end
