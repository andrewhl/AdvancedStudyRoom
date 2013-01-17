['downloader', 'validator', 'scraper'].each { |x| require x }

namespace :downloader do
  desc "Download games"
  task :download_games => :environment do

    downloader = Downloader.new
    scraper = Scraper.new
    time = Time.now
    events = Event.all #Event.find_by_name("ASR League")

    events.each do |event|
      # [Registration.find_by_handle("affytaffy")].each do |registration|
      event.registrations.each do |registration|

        time_before = Time.now
        delay = 3

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

        time_after = Time.now

        if (time_after - time_before) <= delay
          sleep(3)
        end
      end

      # Validate and tag event games
      event.divisions.each do |division|
        validator = Validator.new(division)

        validator.validate_games

        unless event.tags.empty?
          validator.tag_games
        end
      end

    end

  end

end
