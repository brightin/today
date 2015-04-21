require_relative '../lib/chat_notification'

RSpec.describe ChatNotification do
  let(:calendar_name) { 'TestCalendar' }
  let(:events) do
    [
      double(
        summary: 'All-day event',
        start: double(date: '2015-03-02', date_time: nil)
      ),
      double(
        summary: 'Time-based event',
        start: double(date_time: Time.parse('2015-05-04T13:00:00+01:00'))
      )
    ]
  end
  subject { ChatNotification.new(calendar_name, events) }

  describe '#to_s' do
    it 'Returns a formatted chat message' do
      expect(subject.to_s).to eq <<-EOS
TestCalendar:
* All-day event
* Time-based event - 13:00
EOS
    end
  end
end
