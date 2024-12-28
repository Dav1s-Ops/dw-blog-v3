module ApplicationHelper
  include Pagy::Frontend

  class HTMLWithRouge < Redcarpet::Render::HTML
    def initialize(options = {})
      super(options.merge(filter_html: false))
    end

    def link(link, title, content)
      if link.start_with?("http")
        %(<a href="#{link}" title="#{title}" target="_blank" rel="noopener noreferrer">#{content}</a>)
      else
        %(<a href="#{link}" title="#{title}">#{content}</a>)
      end
    end

    def block_code(code, language)
      show_copy_button = language != "nocopy"

      lexer = Rouge::Lexer.find_fancy(language || "text", code) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")
      highlighted_code = formatter.format(lexer.lex(code))

      icon_path = ActionController::Base.helpers.asset_path("copy-icon.svg")
      language_label = language if language && language != "nocopy"
      wrapper_attributes = show_copy_button ? build_wrapper_attributes(code) : ""

      <<~HTML.html_safe
        <div class="code-block-wrapper" #{wrapper_attributes}>
          <div class="code-block-header">
            <span class="code-block-language">#{ERB::Util.html_escape(language_label)}</span>
            #{render_copy_button(show_copy_button, icon_path)}
          </div>
          #{highlighted_code}
        </div>
      HTML
    end

    def build_wrapper_attributes(code)
      "data-controller='copy' data-copy-code-value='#{ERB::Util.html_escape(code)}'"
    end

    def render_copy_button(show, icon_path)
      return unless show

      <<~HTML
        <button class="copy-button" data-action="click->copy#copy">
          <img src="#{icon_path}" alt="Copy" />
          Copy
        </button>
      HTML
    end

    def table(header, body)
      <<~HTML
        <div class="table-container">
          <table>
            <thead>#{header}</thead>
            <tbody>#{body}</tbody>
          </table>
        </div>
      HTML
    end

    def table_row(content)
      "<tr>#{content}</tr>"
    end

    def table_cell(content, alignment)
      if alignment
        "<td style=\"text-align: #{alignment};\">#{content}</td>"
      else
        "<td>#{content}</td>"
      end
    end
  end

  def markdown(content)
    renderer = HTMLWithRouge.new(hard_wrap: true)
    options = {
      fenced_code_blocks: true,
      tables: true,
      autolink: true,
      strikethrough: true,
      footnotes: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  def render_post_content(post)
    text = post.content.dup

    post.images.each do |image|
      filename = image.blob.filename.to_s
      pattern = /!\[#{Regexp.escape(filename)}\]/i
      if text.match?(pattern)
        replacement = %(
          <div class="post-content-image-wrapper">
            <img src="#{url_for(image)}" alt="#{filename}" class="post-content-image" />
          </div>
        ).strip
        text.gsub!(pattern, replacement)
      end
    end

    markdown(text)
  end
end
