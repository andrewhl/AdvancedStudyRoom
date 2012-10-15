require 'net/http'
require 'pry'
require 'open-uri'
require 'zip/zip'

def get_sgf_archive(account, year, month)

  url = "http://www.gokgs.com/servlet/archives/en_US/#{account.handle}-#{year}-#{month}.zip"

  return Net::HTTP.get(URI(url))

end

def download_sgf_archive(account, year, month)
  url = "http://www.gokgs.com/servlet/archives/en_US/#{account.handle}-#{year}-#{month}.zip"
  filename = "#{account.handle}-#{year}-#{month}.zip"

  open("temp/#{filename}", 'wb') do |file|
    file << open(url).read
  end

end

def open_zip
  # Zip::ZipFile.open
end

def test

  return true

end

class Stuff
  def initialize(handle)
    @handle = handle
  end

  def handle
    @handle
  end
end

account = Stuff.new("kabradarf")
# get_sgf_archive(account, 2012, 9)
download_sgf_archive(account, 2012, 8)