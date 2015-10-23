# It's all about the (data)base, all about the (data)base
## Intro
OK, what do I know so far?
* I know a little about relational databases (- what? There are
  others?!?)
* Turns out, RDBMs aren't that efficient once you start referencing other
  tables via foreign keys: a TV show has many seasons, a season has many
  episodes, an episode has many actors and -boom- we're at a four table
  join.
* Instead, we can NoSQL this and use a document-based DB like MongoDB.

Question marks:
* Apparently, RDBMs take a long time to **denormalize** data. What
  exactly is that and why is it necessary? And why is Mongo that much
  faster?
* Under which circumstances would I go for something like Mongo? And how
  do I implement it exactly? (OK, Mongoid seems a good first start.)
* (A) Create an example app that uses Mongo for something.

## Database background
RDBMs are really into normalizing data, whose benefits are apparent when
you consider it: if we also attach a production company to our TV shows
and need to update, let's say, the company address, we would need to go
into every TV show of that particular company and update its address.
Instead, we create a table for production companies and store the
address just once. (In turn, this creates the table join issue, as we
need to **denormalize** again for certain queries where we want to have
both the production company and the TV show present. (Or put
differently, "Denormalization is bringing together different attributes
of a single record, so that all attributes of an entity are easily
accessible in one read. ")

### 3NF / third normal form
The idea of 3NF is that every non-key attribute of a particular table
provides a fact about the key, the whole key and nothing but the key. In
our TV show example, storing the production company's address in the TV
show table clearly violates that.

### Normalization
Apart from taking out anomalies when modifying records (most easily by
carrying around duplicates!, which we eliminate through normalization),
normalization also makes it easier to extend the schema and more importantly,
keeps the application free from a bias toward a particular data access
pattern. This last one is a rule that we move away from when using
MongoDB. (Still, we like being flexible and would prefer to not have
modification anomalies.)

## MongoDB to the rescue
MongoDB: we are storing data in a way that is suited to the application
we're working on! Whereas RDBMs are application-agnostic.

Haha: MongoDB does not support joins in the kernel and uses a rich
document-style of storing data. In consequence, instead of joining
tables when querying, we can pre-join data (via our specific schema)
beforehands and/or combine/join collections within our application after
the query.
Useful knowledge bit: joins are compute-intensive, so the less we need,
the better.
Correlary: If you find your MongoDB schema design resembles an RDBMS
where you are ducktaping together a bunch of collections to get a
join-like behavior, you're doing it wrong - you'd be better off
switching to an actual RDBMS instead.

Haha, 2: we don't have constraints like we do with foreign keys in RDBMs.
And: there are no transactions in the MongoDB world!! Instead, we use
**atomic operations**. And: we don't declare a schema, but have an
implicit one through the individual setup of MongoDB.

## MongoDB, cont'd
When you are tying together collections to reference distributed data,
it is up to you to make sure the 'foreign key' is correct - Mongo will
not check whether it is correct, or more formally: Mongo does not have a
foreign key constraint the way that an RBDMS would.

Instead, Mongo lets you **embed** data: When you store comments for a
blog posts, you can embed the actual comments in the blog post
collection, thereby making sure every comment is at its place.

## Links
http://www.25hoursaday.com/weblog/2009/09/10/BuildingScalableDatabasesDenormalizationTheNoSQLMovementAndDigg.aspx
http://facility9.com/2011/01/three-mistakes-i-made-with-mongodb/
https://docs.mongodb.org/ecosystem/tutorial/model-data-for-ruby-on-rails/
http://snmaynard.com/2012/10/17/things-i-wish-i-knew-about-mongodb-a-year-ago/
Diaspora:
http://www.sarahmei.com/blog/2013/11/11/why-you-should-never-use-mongodb/

YT playlist on MongoDB schema design:
https://www.youtube.com/watch?v=LEwehYpTxCg&list=PLffUyEIMenSnRVQGxRVphq-HelRrSIdzh
