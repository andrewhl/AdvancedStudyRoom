require 'net/http'
require 'uri'
require 'nokogiri'
require 'mechanize'
require 'epitools'

class Scraper

  #############################################################################

  class Row < TypedStruct["viewable white black setup start_time:datetime type result"]
    [:white, :black].each do |name|
      define_method "#{name}=" do |val|
        super val.split.first
      end
    end

    def setup=(val)
      if val =~ /(\d+).(\d+)/
        super [$1, $2].map(&:to_i)
      end
    end

    def viewable=(val)
      case val.downcase
      when "yes"
        super true
      when "no"
        super false
      end
    end

    def viewable?
      viewable
    end

  end

  #############################################################################

  def initialize(delay=2)
    @delay = delay

    @agent = Mechanize.new do |a|
      # ["Mechanize", "Mac Mozilla", "Linux Mozilla", "Windows IE 6", "iPhone", "Linux Konqueror", "Windows IE 7", "Mac FireFox", "Mac Safari", "Windows Mozilla"]
      a.user_agent_alias = "Windows IE 7"
      a.max_history = 10
      #a.log = Logger.new "mechanize.log" if @use_logs
    end
  end

  def get(url)
    if @last_get
      elapsed = Time.now - @last_get
      sleep(@delay - elapsed) if elapsed > @delay
    end

    @last_get = Time.now
    @agent.get(url)
  end

  def get_users(users)
    binding.pry
    Hash[users.map { |user| [user, get_user(user)] }]
  end

  def get_user(username)
    get "http://www.gokgs.com/gameArchives.jsp?user=#{username}"
  end

  #############################################################################

  def parse(page)
    table = page.at("table.grid")
    rows = table.search("tr").to_a[1..-1];
    rows.map do |row|
      # binding.pry
      parse_row row.search("td").map(&:text)
    end.compact
  end

  def parse_row(row)
    case row[-2]
    when "Demonstration"
      nil
    when "Review"
      nil
    when "Simul"
      nil
    when "Free"
      Row.new(*row)
    when "Rated"
      Row.new(*row)
    end
  end

end
