require 'spec_helper'

describe Event do
  context "::check_registration_parity" do
    it "should return true if 2 handles are in the same registration group" do
      date = "2012-09-01"
      Event.check_registration_parity(date, "kabradarf", "DrGoPlayer").should be_true
    end
  end
end
