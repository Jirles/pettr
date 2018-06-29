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

end
