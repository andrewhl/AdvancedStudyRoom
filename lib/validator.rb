['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils', 'epitools'].each { |x| require x }

class Validator

  def initialize filepath
    @filepath = filepath
  end

  class Game < TypedStruct["ruleset"]

  end

  def validate_games

    Zip::ZipFile.open(@filepath) do |zip_file|
      zip_file.each do |f|
        # binding.pry
        f_path = File.join("temp", File.basename(f.to_s))
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exists?(f_path)
        validate_game(f_path.to_s)
        collect_game_data(f_path.to_s)

        FileUtils.remove_entry(f_path)
      end
    end
  end

  def collect_game_data file
    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first


    asr_game = Game.new("test")
    binding.pry
  end


  def validate_game file
    # binding.pry
    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first

    has_valid_tag(game)
  end

  def has_valid_tag game
    tag_phrase = /asr league/i

    # Check that the first node has the tag

    valid_tag = false
    i = 0
    node_limit = 30 # Move limit in which the tag must appear

    game.each do |node|
      unless node.properties["C"].nil?
        valid_tag = true if !node.C.scan(tag_phrase).empty?
      end
      i += 1
      return valid_tag if i > node_limit
    end

  end



end


class Stuff
  def initialize(handle)
    @handle = handle
  end

  def handle
    @handle
  end
end

test = Validator.new("kabradarf-2012-10.zip")
test.validate_games
# test.validate_game("temp/DrGoPlayer-kabradarf.sgf")


# account = Stuff.new("kabradarf")
# get_sgf_archive(account, 2012, 9)
# download_sgf_archive(account, 2012, 8)


# download the zip file
# open the zip file
#   for each file in the ZipFile
#     check that file is valid