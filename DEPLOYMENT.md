# App deployment

## VPS
### Option 1: Dokku
https://github.com/progrium/dokku

Installation guide: http://progrium.viewdocs.io/dokku/installation/
But: needs Linux kernel > 3 and likely a few admin rights that don't
come standard with every VPS.

### Option 2: Passenger
https://www.phusionpassenger.com

Installation guide:
https://www.phusionpassenger.com/library/walkthroughs/basics/ruby/fundamental_concepts.html
The idea: bundle all necessary components into the Rails application
package, first and foremost a web server that is production-ready.
Apache and nginx deliver competitive performance but can't run Rails
code. Unicorn or Puma could to that (much better than WEBRick) but don't
connect to Apache or nginx the same way that Passenger does.

Note: Passenger can run in standalone mode and use its own web server.
Much better though to set it up alongside nginx in production!

Features: Passenger will automatically start new processes to handle a
large number of requests.
