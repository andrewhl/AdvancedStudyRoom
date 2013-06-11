require 'spec_helper'

describe ASR::SGFImporter do

  before(:each) do
    wp = FactoryGirl.create(:registration, handle: 'DrGoPlayer')
    bp = FactoryGirl.create(
      :registration, handle: 'kabradarf', division: wp.division, server: wp.account.server)

    target_path = "./tmp/#{Time.now.to_i}"
    f_path = copy_test_sgf(target_path, 'DrGoPlayer-kabradarf.sgf')

    now = Time.now
    scraper = KgsScraper.new(target_path: target_path, drgoplayermain: 'example.com')
    scraper.stubs(:scrape).with(handle: 'kabradarf', month: now.month, year: now.year).returns([f_path])

    @importer = ASR::SGFImporter.new(scraper: scraper, server: wp.account.server)
  end

  describe "#import_matches" do

    it "should return the valid Matches" do
      matches = @importer.import_matches(handle: 'kabradarf')
      matches.size.should == 1
    end

    it "should save the winner and the loser" do
      matches = @importer.import_matches(handle: 'kabradarf')
      matches.first.winner.should_not be_nil
      matches.first.loser.should_not be_nil
    end

    it "should create the match Comments" do
      matches = @importer.import_matches(handle: 'kabradarf')
      comments = matches.collect { |m| m.comments }.flatten
      comments.size.should == 12
    end

  end

  def copy_test_sgf(target_path, filename)
    dest = "./#{target_path}/#{filename}"
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.cp("./spec/support/#{filename}", dest) unless File.exists?(dest)
    dest
  end
end