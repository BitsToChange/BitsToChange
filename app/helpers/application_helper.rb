module ApplicationHelper
  def markdown(text)
    markdown_obj.render(text).html_safe
  end

  def markdown_obj
    @markdown_obj ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end
end
