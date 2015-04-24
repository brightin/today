class ChatNotification
  attr_reader :calendar_name, :events

  def initialize(calendar_name, events)
    @calendar_name = calendar_name
    @events = events
  end

  def to_s
    "#{calendar_name}:\n#{formatted_events.join("\n")}\n"
  end

  def formatted_events
    events.map do |event|
      start_time = event.start.date_time
      if start_time
        "* #{start_time.strftime('%H:%M')} #{event.summary}"
      else
        "* #{event.summary}"
      end
    end
  end
end
