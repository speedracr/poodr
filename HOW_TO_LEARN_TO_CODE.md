# How to learn to code

## Initial thoughts
So it's effectively 2016 and you want to learn to code. Great - lets see
what we need to cover:

* mobile: native has won, but native is hard. Still: Swift!
* backend: Rails is the old giant. Versatile but not fast. Good all
  around, tricky at times. Still so much better than PHP and Java that
  those should as well vanish.
* frontend: JS frameworks are it. But: hard to understand reasoning when
  just starting out. Seems a basic intro to HTML/CSS/JSS would be cool,
  minimal jQuery and then straight into basic React (or Ember? Angular?)
* backend: with all the JS wizardry going on, node is a strong contender
  it seems. Still, good to get exposure to more than just one language
  if you can make it work at all. (e.g. Rails + React, Swift + React)
* databases: well, leave those out. Yes, Mongo etc are interesting, but
  only once you have an app with >20k users. (Although it gets really
  interesting at that point...)
* Devops: decisive tech here is Docker. Do you need it for development?
  Hard to say - if it works, it works well. If not, you may find
  yourself spending a week to (not) fix it.
* tools/utilities: Guard! (Possibly Gulp..) And git! GitHub! gems, ENV
  (e.g. via Figaro) Branches: master, production, feature branches FTW!
* simple Heroku production app: Do it once at least. For Rails/ Sinatra:
  Set up Puma, set up custom domain - hooray!
* webserver: if you have a VPS, then nginx is interesting to see, I
  guess.
* monitoring, CI: hm, it's interesting to work with. Not sure if you
  really need it.
* APIs: hidden gems, as you wouldn't use many of them in a real-world
  job. Twitter, Imgur: great fun!
* Ruby basics: probably underestimated. See if you can find a csv with
  values and then play around with those. Structs, arrays, ... - all
  really valuable. Scraping web pages, creating files: yes, very much!
  (yml storage?)

## Criteria
Dilemma: to get to a solid skill level will take lots of practice,
realistically only if that includes a period of full-time work. That
then usually means you need (1) to be good enough to be hired as a
developer and (2) have skills that are sought after on the market.
Alternatively, you would probably budget 2-4 years of solid work on the
side.

Also, you'll want to learn stuff that (1) provides a resource-rich
ecosystem, (2) and is future proof. Mostly because it's much more fun to
work that way - for example, when taking part in a hackathon you don't
want to be on the only team that uses .NET.

Conclusion: Ruby, Swift, Node/JS would fit the bill.

## Additional workload
You'll need to figure out how to set up, maintain and extend your
development environment. Again, easier if you're working as part of a
pro team, since any developer with 5+ years of experience will have
figured out anything you'll need to know.

If starting from scratch: indeed something like Mackenzie Child's setup
videos can be a good start, although they'll likely carry you through
not too much more than building your first few apps with 60% efficiency.
Still, more than good enough for starters.

## Teaching
Initial thoughts:
* do you speak English well enough?
* set aside a little budget for Treehouse, CodeSchool, etc
* "tuition"
* Linux or Mac
* mentor sessions twice a week sounds useful

Roadmap
* GitHub and git
* Colemak (optional)
* set up Ruby, Rails, editor (Atom)
* HTML/CSS with Grunt/Gulp/Guard and Bootstrap, Sass, Haml
* then: build Rails app from scratch under guidance to get initial
  overview, incl. basic AJAX/ remote feature
* actually learn to code: basic Ruby with Codecademy/ LCTHW
* Rails: Treehouse? Rails with Zombies?
* deep dive and TDD introduction
* build projects, projects, projects
* deploy on AWS, Heroku
* finish out with Rails API project
* once the basics are done, give React and Swift a try - possibly first:
  do a deep(er) dive into JS before working in React

* pretty quickly: move to vim/emacs, TDD all the way, tickets/agile

Meta
* always push to GitHub, fork/branch/pull request
* HTML/CSS with grunt/gulp and Sass
* Slack

### Perspective
As you continue, you'll find three angles to grow your knowledge: (1)
cleaner code, as in POODR and familiarity with programming concepts and
design patterns, (2) idiomatic competency, e.g. splitting up a model's
functions into `concerns` and `use_cases`, and (3) expanding to other
programming languages, either related (Python, JavaScript) or more
distant (Swift, C++, COBOL) or adjacent (SQL/ Postgres)
In any case, your meta skills (git, vim, TDD) will always improve.
