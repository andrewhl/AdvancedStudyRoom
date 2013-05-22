module PostsHelper

  def markdown_to_html(input)
    markdown = RDiscount.new(input, :smart, :filter_html)
    markdown.to_html.html_safe
  end
end
