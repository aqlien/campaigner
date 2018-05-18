module LayoutHelper

  def navbar_link(name = nil, options = nil, html_options = nil, &block)
    active_class = current_page?(options) ? 'active' : nil

    navbar_item_class = ['nav-item', active_class].join(' ')
    navbar_link_class = [html_options[:class], 'nav-link', nil].join(' ')
    html_options[:class] = navbar_link_class

    content_tag(:li, :class => navbar_item_class) do
      link_to(name, options, html_options, &block)
    end
  end

end
