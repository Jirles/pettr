module UsersHelper

  def set_address(user, current_user)
    if user == current_user
      address = "Your"
    else
      address = "#{user.name}'s"
    end
  end

  def display_dog_profiles(user, current_user)
    address = set_address(user, current_user)
    if user.has_pets?
      content_tag :div, class: "user-doggos-container" do
        concat(content_tag :p, "#{address} doggo(s):")
        user.pets.each do |dog|
          concat(link_to dog.name, owner_dog_path(dog))
        end
      end
    end
  end
end
