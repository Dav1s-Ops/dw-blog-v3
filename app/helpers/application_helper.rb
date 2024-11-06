module ApplicationHelper
  class HTMLWithRouge < Redcarpet::Render::HTML
    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language || "text", code)
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")
      formatter.format(lexer.lex(code))
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
