module UsersHelper

  def display_dog_profiles(user)
    unless user.pet_profiles.empty?
      content_tag :div, class: "user-doggos-container" do
        concat content_tag :p, "Your doggo(s):"
        user.pet_profiles.each do |dog|
          concat link_to dog.name, owner_dog_path(dog)
        end
      end 
    end
  end
end
