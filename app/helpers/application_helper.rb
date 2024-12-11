module ApplicationHelper
  include Pagy::Frontend

  class HTMLWithRouge < Redcarpet::Render::HTML
    def link(link, title, content)
      if link.start_with?("http")
        %(<a href="#{link}" title="#{title}" target="_blank" rel="noopener noreferrer">#{content}</a>)
      else
        %(<a href="#{link}" title="#{title}">#{content}</a>)
      end
    end

    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language || "text", code)
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")
      highlighted_code = formatter.format(lexer.lex(code))

      icon_path = ActionController::Base.helpers.asset_path("copy-icon.svg")

      <<~HTML.html_safe
        <div class="code-block-wrapper" data-controller="copy" data-copy-code-value="#{ERB::Util.html_escape(code)}">
          <div class="code-block-header">
            <button class="copy-button" data-action="click->copy#copy">
              <img src="#{icon_path}" alt="Copy" />
              Copy
            </button>
          </div>
          #{highlighted_code}
        </div>
      HTML
    end
  end

  def markdown(content)
    renderer = HTMLWithRouge.new(filter_html: true, hard_wrap: true)
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
end
