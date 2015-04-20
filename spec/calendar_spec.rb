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

  subject { Calendar.new(ENV['GOOGLE_CALENDAR_ID']) }

  describe '#events' do
    it "returns today's events" do
      VCR.use_cassette('events') do
        result = subject.events
        expect(result).not_to be_empty
      end
    end
  end
end
