module PostsHelper

  def convert_to_html(input)
    input.gsub(/\[/, "<").gsub(/\]/, ">")
  end
end
