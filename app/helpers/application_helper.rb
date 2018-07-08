module ApplicationHelper

  def display_errors(errors)
    if errors
      content_tag :div, :class => 'error-messages-field' do
        errors.full_messages.map do |msg|
          concat(content_tag :p, msg)
        end
      end
    end
  end

  def display_flash_notices
    if flash[:notice]
      content_tag :p, flash[:notice], :class => 'flash-notice-field'
    end
  end

  def set_navbar_options(current_user)
    if current_user
      render partial: 'layouts/loggedin_navbar', locals: {current_user: current_user}
    else
      render 'layouts/not_loggedin_navbar'
    end
  end

  def display_petting_cards(petting, user_pets_dog_display, rating_display)
    content_tag :div, :class => 'petting-card' do
      concat(content_tag :span, link_to(petting.description, petting_path(petting)), :class => "petting-info-span petting-description-link")
      concat(content_tag :span, user_pets_dog_display.call(petting), class: "petting-info-span")
      concat(content_tag :span, rating_display.call(petting.pet_rating), class: "petting-info-span")
      concat(content_tag :span, petting.location, class: "petting-info-span")
    end
  end

end
