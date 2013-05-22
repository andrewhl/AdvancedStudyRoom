Markitup::Rails.configure do |config|
  config.layout = 'markitup'
  config.formatter = lambda { |input|
    RDiscount.new(input, :smart, :filter_html).to_html }
end
