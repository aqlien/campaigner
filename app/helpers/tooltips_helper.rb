module TooltipsHelper
  def info_tooltip(tooltip_text, options={})
    link_tag = if options[:fa_icon].blank?
      content_tag(:a, "", :class => "info_icon")
    else
      content_tag :a, "" do
        fa_icon options[:fa_icon]
      end
    end
    content_tag :div, :class => "rollover" do
      content_tag(:div, clean_text(tooltip_text), :class => "blurb top-left") +
      link_tag
    end
  end

  def variable_info_tooltip(tooltip_text, size, vert_position, horiz_position)
    content_tag :div, :class => "rollover" do
      content_tag(:div, tooltip_text, :class => (size ? (size + "-blurb ") : "blurb ") + vert_position + "-" + horiz_position) +
      content_tag(:a, "", :class => "info_icon")
    end
  end
end
