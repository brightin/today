# Today

Shout out on Hipchat what's on a Google Calendar for today
![Today Hubot Extension Screenshot](screenshot.png)


## Huh? Why?

At our office, every day is different. You never know who you can expect to see there. Some collegues will visit clients, others are doing part time academic work, someone could have a day off or maybe working from home... you get the gist. This little project grew out of the need to be informed about how many people one can expect to see at the office.

Obviously we jot this all this information down in a calendar but I'm too lazy for looking that thing up every day. I simply want an app to shout it at me on HipChat while I have breakfast.


## How can I have this too?

First, you need to set a couple of `ENV` variables, namely:

  * `CALENDAR_URL`: Google Calendar XML feed to read data from. For multiple calendar sources, use `,` as separator.
  * `HIPCHAT_TOKEN`: Access token for posting to HipChat.
  * `HIPCHAT_ROOM`: HipChat room to post today's event summary in.
  * `TZ` (optional): Time zone where your HipChat room is in. Leave this blank to depend on system time zone information.

Then call the following Rake task to send a message to HipChat:

```sh
$ rake hipchat
```

This rake task can be scheduled as a cron job, e.g. via Heroku scheduler or via `crontab` directly, depending on where you host the application.


## Support, questions, ideas, contributing

Please open an issue on GitHub!


