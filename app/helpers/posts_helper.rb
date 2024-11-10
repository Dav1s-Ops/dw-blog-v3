module PostsHelper
  def render_category_links(current_category)
    Category.all.map do |category|
      is_active = current_category && current_category.id == category.id
      category_class = "category #{category.name.downcase}"
      category_class += " active" if is_active
      link_path = is_active ? posts_path : category_posts_path(category: category.slug)
      link_to(link_path, class: category_class) do
        content_tag(:div, category.name, class: "category-text")
      end
    end.join.html_safe
  end
end
