require 'validator'
require 'scraper'

namespace :validator do
  desc "Validate games"
  task :validate_games => :environment do

    validator = Validator.new
    scraper = Scraper.new
    time = Time.now
    event = Event.find_by_name("ASR League")

    # [Registration.find_by_handle("titanpupil")].each do |registration|
    event.registrations.each do |registration|
      has_games = true
      puts "Validating #{registration.handle}"
      scraper.get_sgf_zip(registration.handle)

      # check to see if the get_sgf_zip method returned no_games.txt
      Dir.foreach("./temp/") do |item|
        next if item == "." or item == ".."
        if File.fnmatch("no_games*", item)
          FileUtils.remove_entry("./temp/#{item}")
          has_games = false
        end
      end
      unless has_games == false
        validator.validate_games("./temp/#{registration.handle}-#{Time.now.year}-#{Time.now.month}.zip", "#{registration.handle}")
      end
      sleep(3)
    end

    # Clean up
    Dir.foreach("./temp/") do |item|
      next if item == "." or item == ".."
      if File.fnmatch("*.zip", item) or File.fnmatch("*.sgf", item)
        FileUtils.remove_entry("./temp/#{item}")
      end
    end
  end

  desc "Scrape games"
  task :scrape_games => :environment do

    users = ["kabradarf", "twisted"]

    test = Scraper.new

    # test.get_users(users)
    test.get_sgf_zip("gohandle")
  end
end
# http://www.gokgs.com/servlet/archives/en_US/kabradarf-2012-12.zip