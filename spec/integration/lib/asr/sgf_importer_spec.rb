require 'spec_helper'

describe ASR::SGFImporter do

  # before(:each) do
  #   wp = FactoryGirl.create(:registration, handle: 'DrGoPlayer')
  #   bp = FactoryGirl.create(
  #     :registration, handle: 'kabradarf', division: wp.division, server: wp.account.server)

  #   target_path = "./tmp/#{Time.now.to_i}"
  #   f_path = copy_test_sgf(target_path, 'DrGoPlayer-kabradarf.sgf')

  #   now = Time.now
  #   scraper = KgsScraper.new(target_path: target_path, domain: 'example.com')
  #   scraper.stubs(:scrape_games).with(handle: 'kabradarf', month: now.month, year: now.year).returns([f_path])

  #   @importer = ASR::SGFImporter.new(scraper: scraper, server: wp.account.server)
  # end

  describe "#import_matches" do

    # it "should get an array of matches" do
    #   scraper = KgsScraper.new
    #   scraper.stubs(:scrape_games).
    #     with(handle: 'DrGoPlayer', year: 2012, month: 9).
    #     returns(["./tmp/#{Time.now.to_i}/DrGoPlayer-kabradarf.sgf"])
    #   validator = ASR::SGFValidator.new
    #   validator.stubs(:validate).returns(true)

    #   importer = ASR::SGFImporter.new(scraper: scraper, validator: validator)
    #   matches = importer.import_matches(handle: 'DrGoPlayer', year: 2012, month: 9)
    #   matches.size.should_not be_empty
    #   matches.first.should be_kind_of(Match)
    # end

    # it "should only return valid matches" do
    #   scraper = KgsScraper.new
    #   scraper.stubs(:scrape_games).
    #     with(handle: 'DrGoPlayer', year: 2012, month: 9).
    #     returns([FactoryGirl.build(:sgf_data, :handle => '')])
    #   validator = ASR::SGFValidator.new
    #   validator.stubs(:validate).returns(true)
    # end

    # it "should return the valid Matches" do
    #   matches = @importer.import_matches(handle: 'kabradarf')
    #   matches.size.should == 1
    # end

    # it "should save the winner and the loser" do
    #   matches = @importer.import_matches(handle: 'kabradarf')
    #   matches.first.winner.should_not be_nil
    #   matches.first.loser.should_not be_nil
    # end

    # it "should create the match Comments" do
    #   matches = @importer.import_matches(handle: 'kabradarf')
    #   comments = matches.collect { |m| m.comments }.flatten
    #   comments.size.should == 12
    # end

  end

  def copy_test_sgf(target_path, filename)
    dest = "./#{target_path}/#{filename}"
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.cp("./spec/support/#{filename}", dest) unless File.exists?(dest)
    dest
  end
end