task :environment do
  $:.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
  require 'bundler'
  Bundler.require(:default)
  require 'calendar'
  require 'chat_notification'
end

desc 'Show calendar events on HipChat'
task :hipchat => :environment do
  token = ENV['HIPCHAT_TOKEN'] or raise 'HIPCHAT_TOKEN not set'
  room_name = ENV['HIPCHAT_ROOM'] or raise 'HIPCHAT_ROOM not set'
  calendar_id = ENV['CALENDAR_ID'] or raise 'CALENDAR_ID not set'

  hipchat_room = HipChat::Client.new(token)[room_name]

  calendar_id.split(',').each do |id|
    calendar = Calendar.new(id)
    message = ChatNotification.new(calendar.name, calendar.today)
    hipchat_room.send('Today', message.to_s, message_format: 'text')
  end
end
