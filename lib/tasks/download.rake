require 'downloader'
require 'scraper'

namespace :downloader do
  desc "Validate games"
  task :download_games => :environment do

    downloader = Downloader.new
    scraper = Scraper.new
    time = Time.now
    events = Event.all #Event.find_by_name("ASR League")

    events.each do |event|
      # [Registration.find_by_handle("socratease")].each do |registration|
      event.registrations.each do |registration|
        has_games = true
        puts "Downloading #{registration.handle}'s games..."
        scraper.get_sgf_zip(registration.handle)

        # check to see if the get_sgf_zip method returned no_games.txt
        Dir.foreach("./lib/games/") do |item|
          next if item == "." or item == ".."
          if File.fnmatch("no_games*", item)
            puts "#{registration.handle} has no games"
            FileUtils.remove_entry("./lib/games/#{item}")
            has_games = false
          end
        end
        unless has_games == false
          downloader.download_games("./lib/games/#{registration.handle}-#{Time.now.year}-#{Time.now.month}.zip", "#{registration.handle}")

          # Delete zip file
          FileUtils.remove_entry("./lib/games/#{registration.handle}-#{Time.now.year}-#{Time.now.month}.zip")
        end

        sleep(3)
      end
    end


    # Clean up
    # Dir.foreach("./lib/games/") do |item|
    #   next if item == "." or item == ".."
    #   if File.fnmatch("*.zip", item) or File.fnmatch("*.sgf", item)
    #     FileUtils.remove_entry("./lib/games/#{item}")
    #   end
    # end
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