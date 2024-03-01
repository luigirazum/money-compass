module ApplicationHelper
  def render_content_for
    content_for :header do
      render 'nav_header'
    end

    content_for :messages do
      render 'flash_msgs'
    end
  end
end
