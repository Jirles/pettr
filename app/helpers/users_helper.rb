module UsersHelper

  def user_show_pet_dog_display
    Proc.new{|dog_name| "You pet #{dog_name}!" }
  end

  def display_user_info
    content_tag :span, "George", id: "user-name"
		content_tag :span, "Dallas, TX", id: "user-hometown"
    content_tag :span, "July 3, 1990", id: "user-birthday"
  end

end
