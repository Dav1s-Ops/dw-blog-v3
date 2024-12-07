module ApplicationHelper
  include Pagy::Frontend

  class HTMLWithRouge < Redcarpet::Render::HTML
    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language || "text", code)
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")
      highlighted_code = formatter.format(lexer.lex(code))

      <<~HTML.html_safe
        <div class="code-block-wrapper">
          <div class="code-block-header">
            <button class="copy-button" data-code="#{ERB::Util.html_escape(code)}">Copy</button>
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
