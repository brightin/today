task :environment do
  $:.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
  require 'rubygems'
  require 'bundler/setup'
  Bundler.require
  require 'today'
end

desc 'Show calendar events on HipChat'
task :hipchat => :environment do
  token = ENV['HIPCHAT_TOKEN'] or raise 'HIPCHAT_TOKEN not set'
  room_name = ENV['HIPCHAT_ROOM'] or raise 'HIPCHAT_ROOM not set'
  calendar_url = ENV['CALENDAR_URL'] or raise 'CALENDAR_URL not set'

  hipchat_room = HipChat::Client.new(token)[room_name]

  calendar_url.split(',').each do |url|
    today = Today.new(date: Date.today, google_calendar_url: url)
    next if today.no_events?
    hipchat_room.send('Today', today.to_s, message_format: 'text')
  end
end
