module PettingsHelper

  def petting_index_pets_display
    Proc.new{ | petting | "#{petting.user.full_name} pet #{petting.name}!" }
  end

  #def petting_index_pets_display
  #  Proc.new do | petting, link_to |
  #    if petting.dog_id
  #      "#{petting.user.full_name}" + " pet " + "#{link_to(petting.name, dog_path(petting.dog_id))}" + "!"
  #    else
  #      "#{petting.user.full_name} pet #{petting.name}!"
  #    end
  #  end
  #end

  def petting_index_rating_display
    Proc.new { |rating| "#{rating}/5.0 would do it again" }
  end

  def edit_delete_options(petting, current_user)
    if petting.user == current_user
      capture do
        concat link_to("Edit", edit_petting_path(petting))
        concat ' '
        concat link_to("Delete", petting, method: :delete, data: { confirm: "Are you sure you want to delete this record?" })
      end
    end
  end

  def petting_show_display_dog_name(petting)
    if petting.dog_id
      link_to "#{petting.name}", dog_path(petting.dog_id)
    else
      petting.name
    end
  end

end
