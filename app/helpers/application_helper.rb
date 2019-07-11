module ApplicationHelper
  # markdown to html
  def markdown(text)
    html_render_options = {
      # filter_html:     true, # no input tag or textarea
      # hard_wrap:       true,
      # link_attributes: { rel: 'nofollow' }
      escape_html:       true
    }

    markdown_options = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true,
      disable_indented_code_blocks:          true
    }

    renderer = Redcarpet::Render::HTML.new(html_render_options)
    markdown = Redcarpet::Markdown.new(renderer, markdown_options)
    raw markdown.render(text)
  end
end
