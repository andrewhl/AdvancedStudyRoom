require 'validator'

namespace :validator do
  desc "Validate games"
  task :validate_games => :environment do
    test = Validator.new
    test.validate_games("./lib/kabradarf-2012-10.zip")
  end
end