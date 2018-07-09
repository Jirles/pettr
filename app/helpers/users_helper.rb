module UsersHelper

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

  def user_show_pet_dog_display
    Proc.new{|dog_name| "You pet #{dog_name}!" }
  end

  def user_display_petting_cards(petting, user_pets_dog_display, rating_display)
    content_tag :div, :class => 'petting-card' do
      concat(content_tag :span, link_to(petting.description, petting_path(petting)), :class => "petting-info-span petting-description-link")
      concat(content_tag :span, user_pets_dog_display.call(petting.name), class: "petting-info-span")
      concat(content_tag :span, rating_display.call(petting.pet_rating), class: "petting-info-span")
      concat(content_tag :span, petting.location, class: "petting-info-span")
      concat(link_to "Edit", edit_petting_path(petting))
    end
  end

end
