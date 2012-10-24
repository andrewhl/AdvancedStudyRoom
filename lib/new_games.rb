require 'net/http'
require 'pry'
require 'open-uri'
require 'zip/zip'


def download_sgf_archive(account, year, month)
  url = "http://www.gokgs.com/servlet/archives/en_US/#{account.handle}-#{year}-#{month}.zip"
  filename = "#{account.handle}-#{year}-#{month}.zip"

  open("temp/#{filename}", 'wb') do |file|
    file << open(url).read
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

# test = Validator.new("temp/kabradarf-2012-10.zip")
# test.validate_games

# account = Stuff.new("kabradarf")
# get_sgf_archive(account, 2012, 9)
# download_sgf_archive(account, 2012, 8)


# download the zip file
# open the zip file
#   for each file in the ZipFile
#     check that file is valid