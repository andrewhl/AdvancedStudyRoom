# # encoding: utf-8

# require 'spec_helper'
# require 'scraper'

# describe Scraper do
#   # subject(:scraper) { Scraper.new("http://www.gokgs.com/gameArchives.jsp?user=andrew&year=2012&month=7") }
#   subject(:scraper) { Scraper.new }

#   def open_test_html(filename)
#     Nokogiri::HTML(open("spec/test_pages/#{filename}"))
#   end

#   it "should initialize" do
#     lambda { Scraper.new }.should_not raise_error
#   end

#   it "parses pages" do
#     # binding.pry
#     page = open_test_html("kabradarf.html")

#     # binding.pry
#     results = scraper.parse(page)
#     results.first.inspect.should == "#<struct Scraper::Row viewable=true, white=\"modalna\", black=\"kabradarf\", setup=[19, 19], start_time=Wed, 12 Aug 2009 18:47:00 +0000, type=\"Free\", result=\"B+Res.\">"

#   end

#   describe "html row parsing" do

#     context "free games" do

#       it "should parse successfully" do
#         row = ["Yes",
#                 "modalna [?]",
#                 "kabradarf [-]",
#                 "19×19 ",
#                 "9/8/12 6:47 PM",
#                 "Free",
#                 "B+Res."]


#         result = scraper.parse_row(row)

#         result.white.should == "modalna"
#         result.setup.should == [19,19]
#         result.viewable.should == true
#         result.start_time.should be_a(DateTime)
#       end

#     end

#     context "rated games" do

#       it "should parse them successfully" do
#         row = ["Yes",
#                 "modalna [?]",
#                 "kabradarf [-]",
#                 "19×19 ",
#                 "9/8/12 6:47 PM",
#                 "Rated",
#                 "B+Res."]

#         result = scraper.parse_row(row)

#         result.white.should == "modalna"
#         result.setup.should == [19,19]
#         result.viewable.should == true
#         result.start_time.should be_a(DateTime)
#       end

#     end

#     context "demonstration games" do

#       it "should not parse them" do
#         row = ["Yes",
#                "kabradarf [-]",
#                "19×19 ",
#                "9/8/12 6:47 PM",
#                "Demonstration",
#                "Unfinished"]

#         result = scraper.parse_row(row).should be_nil

#       end

#     end

#     context "review games" do

#       it "should not parse them" do
#         row = ["Yes",
#                "kabradarf [-]",
#                "19×19 ",
#                "9/8/12 6:47 PM",
#                "Review",
#                "Unfinished"]

#         result = scraper.parse_row(row).should be_nil
#       end
#     end

#     context "simul games" do

#       it "should not parse them" do
#         row = ["Yes",
#                "kabradarf [-]",
#                "19×19 ",
#                "9/8/12 6:47 PM",
#                "Simul",
#                "Unfinished"]

#         result = scraper.parse_row(row).should be_nil
#       end
#     end
#   end

#   context ".get_users" do
#     it "should return an array of users" do
#       # scraper.users.should == ["kabradarf"]
#       pending
#     end
#   end
# end