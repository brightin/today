require_relative '../lib/calendar'

require 'vcr'
require 'dotenv'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

RSpec.describe Calendar do
  before do
    Dotenv.load
  end

  subject { Calendar.new(ENV['CALENDAR_ID']) }

  describe '#events' do
    it "returns an enumerable object" do
      VCR.use_cassette('events') do
        expect(subject.events).to respond_to(:each)
      end
    end
  end

  describe '#today' do
    it "returns an enumerable object" do
      VCR.use_cassette('today') do
        expect(subject.today).to respond_to(:each)
      end
    end
  end
end
