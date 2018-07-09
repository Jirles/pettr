module DogsHelper

  def dog_show_rating_display
    Proc.new { |rating| "#{rating} stars" }
  end

  def dog_pet_by_user_display
    Proc.new { | petting | "#{petting.name} was pet by #{petting.user.full_name}!" }
  end

  def set_address(user, current_user)
    if user == current_user
      address = "Your"
    else
      address = "#{user.name}'s"
    end
  end

  def display_dog_profiles(user, current_user)
    if user.has_pets?
      address = set_address(user, current_user)
      content_tag :div, class: "user-doggos-container" do
        concat(content_tag :h3, "#{address} doggo(s):")
        user.pets.each do |dog|
          concat(link_to dog.name, owner_dog_path(dog))
        end
      end
    end
  end

end
