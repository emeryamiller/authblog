module PostsHelper
  class ColorizedCodeHTML < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language) 
    end
  end

  class AbstractHTML < Redcarpet::Render::HTML
    def header(text, header_level)
      ""
    end

    def image(link, title, alt_text)
      ""
    end

    def autolink(link, link_type)
      ""
    end

    def link(link, title, alt_text)
      ""
    end
  end

  def abstract_markdown(source)
    markdown_options = [:no_intra_emphasis, :fenced_code_blocks, :lax_html_blocks].each_with_object({}) { |option, h| h[option] = true }
    render_options = [:hard_wrap].each_with_object({}) { |option, h| h[option] = true }
    converter = Redcarpet::Markdown.new(AbstractHTML.new(render_options), markdown_options)
    converter.render(source).html_safe
  end

  def markdown(source)
    markdown_options = [:no_intra_emphasis, :tables, :fenced_code_blocks, :lax_html_blocks, :autolink, :strikethrough, :superscript].each_with_object({}) { |option, h| h[option] = true }
    render_options = [:hard_wrap].each_with_object({}) { |option, h| h[option] = true }
    converter = Redcarpet::Markdown.new(ColorizedCodeHTML.new(render_options), markdown_options)
    converter.render(source).html_safe
  end
end
