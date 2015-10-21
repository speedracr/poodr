# It's all about the (data)base, all about the (data)base
## Intro
OK, what do I know so far?
* I know a little about relational databases (- what? There are
  others?!?)
* Turns out, RDBs aren't that efficient once you start referencing other
  tables via foreign keys: a TV show has many seasons, a season has many
  episodes, an episode has many actors and -boom- we're at a four table
  join.
* Instead, we can NoSQL this and use a document-based DB like MongoDB.

Question marks:
* Apparently, RDBs take a long time to **denormalize** data. What
  exactly is that and why is it necessary? And why is Mongo that much
  faster?
* Under which circumstances would I go for something like Mongo? And how
  do I implement it exactly? (OK, Mongoid seems a good first start.)
* (A) Create an example app that uses Mongo for something.

## Links
http://www.25hoursaday.com/weblog/2009/09/10/BuildingScalableDatabasesDenormalizationTheNoSQLMovementAndDigg.aspx
http://facility9.com/2011/01/three-mistakes-i-made-with-mongodb/
https://docs.mongodb.org/ecosystem/tutorial/model-data-for-ruby-on-rails/
http://snmaynard.com/2012/10/17/things-i-wish-i-knew-about-mongodb-a-year-ago/
Diaspora:
http://www.sarahmei.com/blog/2013/11/11/why-you-should-never-use-mongodb/

YT playlist on MongoDB schema design:
https://www.youtube.com/watch?v=LEwehYpTxCg&list=PLffUyEIMenSnRVQGxRVphq-HelRrSIdzh
