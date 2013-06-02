
namespace :manager do

  desc "Import matches from the servers"
  task :import => :environment do

    begin
      logger.started('IMPORT')

      server = Server.where(name: 'KGS').first
      importer = ASR::SGFImporter.new(server: server, ignore_case: true)
      regs = Registration.
                where('registrations.active = ? AND accounts.server_id = ?', true, server.id).
                includes(:account)
      regs.each do |reg|
        logger.w "Processing #{reg.account.handle}..."
        started_at = Time.now.to_f

        matches = importer.import_matches(handle: reg.account.handle)
        matches.each(&:save)

        time = (Time.now.to_f - started_at).to_f.round(2)
        logger.wl "#{matches.size} matches in #{time} seconds"
      end
    rescue Exception => exc
      logger.error exc
    ensure
      logger.ended
    end
  end


  desc "Validate unvalidated matches"
  task :validate => :environment do

    begin
      logger.started('VALIDATE')

      Event.all.each do |event|
        div_matches = Match.unvalidated.by_event(event).group_by(&:division_id)
        div_matches.each do |div_id, matches|
          div = Division.where(id: div_id).includes(:ruleset).first
          validator = ASR::MatchValidator.new(div.rules)
          matches.each do |match|
            logger.w "Validating #{match.digest}..."

            is_valid = validator.valid?(match)
            match.update_attributes(
              valid_match: is_valid,
              validation_errors: validator.errors.join(','))

            logger.wl is_valid.to_s.upcase
          end
        end
      end
    rescue Exception => exc
      logger.exception exc
    ensure
      logger.ended
    end
  end

  namespace :validate do
    desc 'Recheck the validation of all matches'
    task :redo => :environment do

      Match.update_all(valid_match: nil, validation_errors: nil)
      Rake::Task['manager:validate'].reenable
      Rake::Task['manager:validate'].invoke
    end
  end


  desc "Check tags for unchecked matches"
  task :tags => :environment do

    begin
      logger.started('TAGS')

      Event.all.each do |event|
        tag_checker = ASR::TagChecker.new(event.tags)
        Match.unchecked.by_event(event).each do |match|
          logger.w "Checking...#{match.digest}"

          node_limit = match.division.rules[:node_limit]
          is_tagged = tag_checker.tagged?(match.tags, node_limit)
          match.update_attribute(:tagged, is_tagged)

          logger.wl is_tagged.to_s.upcase
        end
      end
    rescue Exception => exc
      logger.exception exc
    ensure
      logger.ended
    end
  end

  namespace :tags do
    desc 'Recheck the tags of all matches'
    task :redo => :environment do

      Match.update_all(tagged: nil)
      Rake::Task['manager:tags'].reenable
      Rake::Task['manager:tags'].invoke
    end
  end

  desc "Calculate points for all events"
  task :points => :environment do

    begin
      logger.started 'POINTS'

      finder = ASR::MatchFinder.new(from: Time.now.beginning_of_month, to: Time.now.end_of_month)
      pm = ASR::PointManager.new(finder: finder)

      Event.all.each do |event|
        logger.wl "EVENT #{event.name}..."

        event.registrations.each do |reg|
          logger.w "Calculating #{reg.handle}..."

          matches = finder.by_registration(reg).tagged.valid.without_points
          points = pm.points_for(matches)
          points.each(&:save)
          points.collect(&:match).each { |m| m.update_attribute(:has_points, true)}

          logger.wl "#{points.size.to_f} points"
        end
      end
    rescue Exception => exc
      logger.exception exc
    ensure
      logger.ended
    end
  end



  namespace :points do
    desc 'Recount the points of all matches'
    task :redo => :environment do

      Match.update_all(has_points: false)
      Point.destroy_all
      Rake::Task['manager:points'].reenable
      Rake::Task['manager:points'].invoke
    end

    desc "Total registration points"
    task :total => :environment do

      begin
        logger.started 'TOTALLING POINTS'

        Event.all.each do |event|
          logger.wl "EVENT #{event.name}..."
          event.registrations.each do |reg|
            logger.w "Totalling #{reg.handle}..."
            total = reg.points.collect(&:count).inject(&:+) || 0
            reg.update_attribute(:points_this_month, total)

            logger.wl "#{total} points"
          end
        end
      rescue Exception => exc
        logger.exception exc
      ensure
        logger.ended
      end
    end

  end

  task :ranks => :environment do
    desc 'Get ranks from comments for all registrations'

    begin
      logger.started 'RANKS'

      Registration.all.each do |reg|
        logger.wl "REGISTRATION #{reg.handle}..."
        rank = Utilities::rank_convert(reg.get_rank)
        reg.account.update_attribute(:rank, rank)
        logger.wl "Rank: #{Utilities::format_rank(rank)}"
      end
    rescue Exception => exc
      logger.exception exc
    ensure
      logger.ended
    end
  end

  # desc "Perform all actions"
  # task :all => :environment do
  #   tasks = [:download, :tag_games, :validate_games, :calculate_points]

  #   tasks.map { |task| Rake::Task["manager:" + task.to_s].reenable }
  #   tasks.map { |task| Rake::Task["manager:" + task.to_s].invoke }
  # end

  # desc "Perform all validations (no download)"
  # task :all_validations => :environment do
  #   tasks = [:tag_games, :validate_games, :calculate_points]

  #   tasks.map { |task| Rake::Task["manager:" + task.to_s].reenable }
  #   tasks.map { |task| Rake::Task["manager:" + task.to_s].invoke }
  # end

  private

    def logger
      @logger ||= TaskLogger.new("#{Rails.root}/log/manager.log")
    end

end
