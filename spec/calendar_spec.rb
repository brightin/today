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
        result = subject.events
        expect(result).to respond_to(:each)
      end
    end
  end
end
