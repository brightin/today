require_relative 'client'

class Calendar
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def name
    @name ||= client.calendar(calendarId: id).summary
  end

  def events(opts = {})
    client.calendar_events(
      opts.merge(calendarId: id, singleEvents: true)
    )
  end

  def today(opts = {})
    now = Time.now
    events(
      {
        orderBy: 'startTime',
        timeMin: Time.new(now.year, now.month, now.day, 0, 0, 0).iso8601,
        timeMax: Time.new(now.year, now.month, now.day, 23, 59, 59).iso8601
      }.merge(opts)
    )
  end

  private

  def client
    @client ||= Client.new
  end
end
