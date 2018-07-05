module ApplicationHelper

  def display_errors
    if @errors
      content_tag :div, :class => 'error-messages-field' do
        @errors.full_messages.map do |msg|
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

end
