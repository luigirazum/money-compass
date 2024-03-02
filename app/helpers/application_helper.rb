module ApplicationHelper
  def render_content_for(form)
    content_for :header do
      render 'nav_header', locals: { f: form }
    end

    content_for :messages do
      render 'flash_msgs'
    end
  end

  def button_name_by_controller
    return 'Next' if controller_name == 'registrations'
    return 'Request' if controller_name == 'passwords'

    'Log In'
  end

  def screen_name_by_controller
    return 'login' if controller_name == 'sessions'
    return 'register' if controller_name == 'registrations'
    return controller_name.singularize if controller_name == 'passwords'
    if (controller_name == 'categories' or controller_name == 'payments') && (action_name == 'index')
      return controller_name
    end

    "#{action_name} #{controller_name.singularize}"
  end

  def back_path_by_controller
    return new_user_session_path if controller_name == 'passwords'

    return category_payments_path(session[:initial_category]) if controller_name == 'payments' and action_name == 'new'

    root_path
  end

  def nav_button_by_controller
    if controller_name == 'categories' and action_name == 'index'
      out = ''
      out << render('icon',
                    locals: { icon_name: 'menu' },
                    data: { 'categories-target': 'menu' }, class: 'icon')
      out << render('icon',
                    locals: { icon_name: 'close' },
                    data: { 'categories-target': 'close' }, class: 'icon icon--hidden')

      return tag.button(type: 'button', class: 'nav-toggle',
                        data: { action: 'click->categories#toggleMenu' }, aria: { label: 'open navigation' }) do
               out.html_safe
             end
    end

    link_to(back_path_by_controller, class: 'btn btn--nav') do
      render('icon', locals: { icon_name: 'back-arrow' }, class: 'icon')
    end
  end

  def svg_icon(name)
    return if name.nil?

    out = render 'application/icons/svgs', icon_name: name

    out.html_safe
  end

  def create_custom_svg(icon_name, **options)
    newsvg = tag.svg
    newsvg.clear
    newsvg = svg_icon(icon_name)
    custom_options = []
    options&.each_pair do |k, v|
      custom_options << "#{k}-#{v.to_a.first.first}=\"#{v.to_a.first.second}\"" if v.is_a? Hash

      custom_options << "#{k}=\"#{v}\"" unless v.is_a? Hash
    end
    newsvg.gsub('<svg', "<svg #{custom_options.join(' ')}").html_safe
  end

  def display_flash
    return if flash.empty?

    out = tag.div(class: "flash center flash--#{flash[:notice] ? 'notice' : 'alert'}") do
      tag.p(class: 'flash__message') do
        sanitize flash[:notice] ? notice : alert
      end
    end

    out.html_safe
  end
end
