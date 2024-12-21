module PostsHelper
  def render_category_links(current_category)
    Category.all.map do |category|
      is_active = current_category && current_category.id == category.id
      category_class = "category #{category.name.downcase}"
      category_class += " active" if is_active
      link_path = is_active ? posts_path : category_posts_path(category: category.slug)
      link_to(link_path, class: category_class, data: { categories_bar_target: "category" }) do
        content_tag(:div, category.name, class: "category-text")
      end
    end.join.html_safe
  end

  def posts_header(current_category)
    title = current_category ? "#{current_category.name} Posts" : "All Posts"
    content_tag(:h2, class: "category-title-text") do
      concat title
      concat " "
      concat(
        image_tag(
          "question-filled.svg",
          alt: "Tooltip icon",
          class: "tooltip-icon",
          data: { 
            controller: "tooltip",
            action: "mouseover->tooltip#show mouseout->tooltip#hide",
            tooltip_text: "This section displays posts filtered by category or all posts if no category is selected."
          }
        )
      )
    end
  end

  def formatted_post_date(post)
    post.created_at.strftime("%b") + " " + post.created_at.day.ordinalize + ", " + post.created_at.strftime("%Y")
  end

  def first_paragraph_of_markdown(content, length: 230)
    return "" if content.nil? || content.strip.empty?
    html = markdown(content)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    first_p = doc.at("p")
    if first_p
      truncated_text = truncate(first_p.text, length: length)
      "<p>#{truncated_text}</p>".html_safe
    else
      ""
    end
  end
end
