Markitup::Rails.configure do |config|
  config.formatter = -> markup { BBCodeParser.parse(markup) }
end