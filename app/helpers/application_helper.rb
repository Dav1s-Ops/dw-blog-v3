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
      lexer = Rouge::Lexer.find_fancy(language || "text", code)
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight")
      highlighted_code = formatter.format(lexer.lex(code))

      icon_path = ActionController::Base.helpers.asset_path("copy-icon.svg")
      language_label = language ? language : ""

      <<~HTML.html_safe
        <div class="code-block-wrapper" data-controller="copy" data-copy-code-value="#{ERB::Util.html_escape(code)}">
          <div class="code-block-header">
            <span class="code-block-language">#{ERB::Util.html_escape(language_label)}</span>
            <button class="copy-button" data-action="click->copy#copy">
              <img src="#{icon_path}" alt="Copy" />
              Copy
            </button>
          </div>
          #{highlighted_code}
        </div>
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
end
