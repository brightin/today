require 'today/calendar'
require 'today/event_printer'

class Today
  extend Memoist
  VERSION = "1.1.0"
  attr_accessor :date

  def initialize(options = {})
    @date = options[:date] || Date.today
    @google_calendar_url = options[:google_calendar_url]
  end

  memoize def calendar
    fetch_calendar
  end

  def fetch_calendar
    Calendar.new open(calendar_url)
  end

  def calendar_url
    uri = URI.parse(@google_calendar_url)
    tomorrow = date.next
    start_min = "start-min=#{date}"
    start_max = "start-max=#{tomorrow}"
    uri.query = [uri.query, start_min, start_max].compact.join('&')
    uri.to_s
  end

  memoize def event_printer
    EventPrinter.new(@date)
  end

  def no_events?
    calendar.empty?
  end

  def the_date
    @date.strftime('%A, %B %e').gsub("  ", " ")
  end

  def to_s
    "#{calendar.name}:\n" + calendar.events.map { |event| "* #{event_printer.print(event)}" }.join("\n")
  end

end
