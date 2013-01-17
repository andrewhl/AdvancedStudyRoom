['pry'].each { |x| require x }

class Validator

  def initialize division
    @division = division
    @matches = division.matches
  end

  def validate_games
    puts "Checking #{@division.name}..."
    @matches.each do |match|
      puts "Checking #{match.white_player_name} vs. #{match.black_player_name}..."
      if match.is_valid?
        match.update_attribute(:valid_game, true)
      else
        match.update_attribute(:valid_game, false)
      end
    end
  end

  def tag_games force=false
    @matches.each do |match|
      unless force
        next if match.tagged == true or match.tagged == false
      end

      if match.has_valid_tag?
        match.update_attribute(:tagged, true)
      else
        match.update_attribute(:tagged, false)
      end
    end
  end

end