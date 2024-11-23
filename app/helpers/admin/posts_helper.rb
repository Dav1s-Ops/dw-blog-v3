module Admin::PostsHelper
  def admin_action_button(path, icon, label, options = {})
    link_to path, options.merge(class: "#{options[:class]} admin-posts__action-link-#{label}") do
      inline_svg_tag(icon, class: "admin-posts__icon") +
      content_tag(:span, label, class: "admin-posts__action-text")
    end
  end
end
