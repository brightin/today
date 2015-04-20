require_relative 'client'

class Calendar
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def events(opts = {})
    client.calendar_events(opts.merge(calendarId: id))
  end

  private

  def client
    @client ||= Client.new
  end
end
