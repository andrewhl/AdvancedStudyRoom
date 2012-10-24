require 'net/http'
require 'pry'
require 'open-uri'
require 'zip/zip'
require 'sgf'

class Validator

  def initialize(filepath)
    @filepath = filepath
  end

  def open_games(file)
    Zip::ZipFile.open(@filepath) do |zip_file|

      zip_file.each do |f|
        # validate_game(f)

      end
    end

  end

  def validate_games
    # loop through games folder and open each sgf file for validation
  end

  def validate_game(file)
    binding.pry
    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first

    has_valid_tag(game)
  end

  def has_valid_tag(game)
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
      return if i == 30
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

test = Validator.new("temp/kabradarf-2012-10.zip")
test.validate_games
# test.validate_game("temp/DrGoPlayer-kabradarf.sgf")


# account = Stuff.new("kabradarf")
# get_sgf_archive(account, 2012, 9)
# download_sgf_archive(account, 2012, 8)


# download the zip file
# open the zip file
#   for each file in the ZipFile
#     check that file is valid