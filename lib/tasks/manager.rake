['downloader', 'validator', 'scraper', 'point_calculator'].each { |x| require x }

namespace :manager do
  desc "Download games"
  task :download => :environment do

    downloader = Downloader.new
    scraper = Scraper.new
    time = Time.now
    events = Event.all #Event.find_by_name("ASR League")

    events.each do |event|
      # [Registration.find_by_handle("kosach")].each do |registration|
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
      # event.divisions.each do |division|
      #   validator = Validator.new(division)

      #   validator.validate_games

      #   unless event.tags.empty?
      #     validator.tag_games
      #   end

      # end

    end

  end

  desc "Calculate points for all events"
  task :calculate_points => :environment do

    puts "Calculating points..."
    events = Event.all
    events.each do |event|
      puts "Calculating #{event.name}..."
      event.divisions.each do |division|
        puts "Calculating #{division.name}..."
        calculator = PointCalculator.new(division)
        calculator.calculate
      end
    end
  end

  desc "Validate games for all events"
  task :validate_games => :environment do

    events = Event.all
    events.each do |event|
      event.divisions.each do |division|
        puts "Calculating #{division.name}..."
        validator = Validator.new(division)
        validator.validate_games
      end
    end
  end

  desc "Check and tag all games"
  task :tag_games => :environment do

    events = Event.all
    events.each do |event|
      next if event.tags.empty?
      event.divisions.each do |division|
        puts "Calculating #{division.name}..."
        validator = Validator.new(division)
        validator.tag_games
      end
    end
  end

  desc "Perform all actions"
  task :all => :environment do
    tasks = [:download, :tag_games, :validate_games, :calculate_points]

    tasks.map { |task| Rake::Task["manager:" + task.to_s].reenable }
    tasks.map { |task| Rake::Task["manager:" + task.to_s].invoke }
  end

  desc "Perform all validations (no download)"
  task :all_validations => :environment do
    tasks = [:tag_games, :validate_games, :calculate_points]

    tasks.map { |task| Rake::Task["manager:" + task.to_s].reenable }
    tasks.map { |task| Rake::Task["manager:" + task.to_s].invoke }
  end


end
