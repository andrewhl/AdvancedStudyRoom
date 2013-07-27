require 'spec_helper'

describe Event do
  context "::check_registration_parity" do

    let(:args) { { date: '2012-09-01', handles: ['kabradarf', 'DrGoPlayer'], ignore_case: true } }

    before :each do
      # TODO: Use database cleaner
      EventPeriod.destroy_all;RegistrationGroup.destroy_all;Registration.destroy_all;

      event_period = FactoryGirl.create(:event_period, starts_at: '2012-09-01', ends_at: '2012-09-30')
      reg_group = FactoryGirl.create(:registration_group, event_period: event_period)
      @registration = FactoryGirl.create(:registration, handle: 'kabradarf',
        registration_group: reg_group, event_period: event_period)
      FactoryGirl.create(:registration, handle: 'DrGoPlayer',
        registration_group: reg_group, event_period: event_period)
    end

    it "should return true if 2 handle registrations have parity" do
      test_args = { date: '2012-09-01', handles: ['kabradarf', 'DrGoPlayer'], ignore_case: true }
      Event.check_registration_parity(test_args).should be_true
    end

    it "should return false if the date does not match any event period" do
      Event.check_registration_parity(args.merge(date: '2012-10-01')).should be_false
    end

    it "should return false if an account does not exist for a handle" do
      test_args = args.merge(handles: ['kabradarf', 'hello'])
      Event.check_registration_parity(test_args).should be_false
    end

    it "should return false if :ignore_case => true and a handle has wrong case" do
      test_args = args.merge(handles: ['KABRADARF', 'DrGoPlayer'], ignore_case: false)
      Event.check_registration_parity(test_args).should be_false
    end

    it "should return false if the registrations are in different registration groups" do
      @registration.update_attribute :registration_group, nil
      Event.check_registration_parity(args).should be_false
    end

    it "should raise an ArgumentError unless two handles are given" do
      expect {
        Event.check_registration_parity(args.merge(handles: ['kabradarf']))
      }.to raise_error
      expect {
        Event.check_registration_parity(args.merge(handles: ['kabradarf', 'DrGoPlayer', 'hello']))
      }.to raise_error
    end
  end
end
