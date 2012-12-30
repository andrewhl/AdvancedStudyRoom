require 'net/http'
require 'uri'
require 'nokogiri'
require 'mechanize'
# require 'epitools'

class Scraper

#   #############################################################################

#   class Row < TypedStruct["viewable white black setup start_time:datetime type result"]
#     [:white, :black].each do |name|
#       define_method "#{name}=" do |val|
#         super val.split.first
#       end
#     end

#     def setup=(val)
#       if val =~ /(\d+).(\d+)/
#         super [$1, $2].map(&:to_i)
#       end
#     end

#     def viewable=(val)
#       case val.downcase
#       when "yes"
#         super true
#       when "no"
#         super false
#       end
#     end

#     def viewable?
#       viewable
#     end

#   end

#   #############################################################################

  def initialize(delay=3)
    @delay = delay

    @agent = Mechanize.new do |a|
      # ["Mechanize", "Mac Mozilla", "Linux Mozilla", "Windows IE 6", "iPhone", "Linux Konqueror", "Windows IE 7", "Mac FireFox", "Mac Safari", "Windows Mozilla"]
      a.user_agent_alias = "Windows IE 7"
      a.max_history = 10
      #a.log = Logger.new "mechanize.log" if @use_logs
    end
  end

  def get(url)
    # if @last_get
    #   elapsed = Time.now - @last_get
    #   binding.pry if (@delay - elapsed > 0)
    #   sleep(@delay - elapsed) if elapsed > @delay
    # end

    # @last_get = Time.now
    @agent.pluggable_parser.default = Mechanize::Download
    # @agent.pluggable_parser.zip = Mechanize::FileSaver
    sleep(@delay)
    a = @agent.get(url)
    a = a.search("p > a").first
    url = a.first[1]
    filename = url.scan(/en_US\/(.+)/).flatten[0]
    url = "http://www.gokgs.com" + url
    binding.pry
    @agent.get(url)
    # @agent.get(url).save(filename)
  end

  def get_sgf_zip(user)
    time = Time.now
    Net::HTTP.start("www.gokgs.com") { |http|
      # binding.pry
      resp = http.get("/servlet/archives/en_US/#{user}-#{time.year}-#{time.month}.zip")
      if resp.is_a? Net::HTTPNotFound # if the player does not exist
        FileUtils.touch("./lib/games/no_games.txt")
      # elsif # player has no games

      else
        open("#{user}-#{time.year}-#{time.month}.zip", "wb") { |file|
          file.write(resp.body)
          FileUtils.mv("#{user}-#{time.year}-#{time.month}.zip", "lib/games/")
        }
      end
    }
  end

  def get_users(users)
    Hash[users.map { |user| [user, get_user(user)] }]
  end

  def get_user(username)
    # binding.pry
    get "http://www.gokgs.com/gameArchives.jsp?user=#{username}"
  end

#   #############################################################################

#   def parse(page)
#     table = page.at("table.grid")
#     rows = table.search("tr").to_a[1..-1];
#     rows.map do |row|
#       # binding.pry
#       parse_row row.search("td").map(&:text)
#     end.compact
#   end

#   def parse_row(row)
#     case row[-2]
#     when "Demonstration"
#       nil
#     when "Review"
#       nil
#     when "Simul"
#       nil
#     when "Free"
#       Row.new(*row)
#     when "Rated"
#       Row.new(*row)
#     end
#   end

end
