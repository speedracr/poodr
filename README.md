# Here be object-oriented code.

## Command-line
List files: with `ls -lh`, CLI will list out all files and directories,
include detailed info and display file sizes in human readable format.
`ls -1` simply lists out all elements on new lines.

Find files: `find . -name '*.html'`
In detail: specify the directory (optionally), pass in `-name` and
argument, ideally escaped to unconfuse the CLI.

`curl`: to download a file, do a `curl
https://my.file.tld/file.name > this_is_the_local_file.name` and curl
will download the file in question.

`ln -s`: symlink, creates a wormhole between an actual file and its
representation in a totally different location. The beauty: file is
being updated in the original location > change propagates to symlink,
as well, and the symlink can even be tracked by git and be included in a
repo. Syntax: `ln -s source/file.name my-symlink-file.name`

## Bundle / devops
`bundle outdated` lists all outdated gems (without making changes).

Deploying workflow: Make sure `production` is ready in a CI-tested
version!!! Steps: come into office, merge master into production, push
production and wait for it to go green! Then, deploying to production is
a matter of single minutes, not 15+min.

## Ruby-related
### Splat operator
This is one that takes getting used to: the * splat operator adds spice
to methods and calls.
The nice thing about it: We can create methods without having to specify
the exact number of arguments they take.

``` ruby
def say(what, *people)
  people.each { |person| puts "#{person}: #{what}" }
end

say "Hello!", "Alice", "Bob", "Carl"
# Alice: Hello!
# Bob: Hello!
...
```

Also used to pass in arguments and a final hash with options:
``` ruby
def args_and_opts(*args, opts)
  puts "arguments: #{args} options: #{opts}"
end

args_and_opts 1,2,3, a: 5
# arguments: [1,2,3] options: {:a => 5}
```

Also turns values into arrays:
``` ruby
a = *"Hello"  # ["Hello"]
a = *(1..3)   # [1,2,3]
```

Further reading:
[https://4loc.wordpress.com/2009/01/16/the-splat-operator-in-ruby/]

### Mini Ruby: `squish`
Takes a number of concatenated strings or an array, removes whitespace
on both ends and returns a single string. Also replaces any 2+
character-whitespaces with single-character whitespace - in short, turns
a number of arguments into a string that is optimized for being
displayed to the user.

### Enumerables
The work horse, so read up on this isht.

One handy trick: `.map`. In contrast to `.each`, this will return a new
array with the result of the map operation:
``` ruby
@charity.charity_admins.map { |a| a.user_id }
```

Here is the kicker: We can shorten that to
``` ruby
@charity.charity_admins.map(&:user_id)
```

Even works to run a certain method on each element of an array:
``` ruby
class Numeric
def plusone
  self + 1
end
end
[1,2,3].map(&:plusone)
```
More:
[http://stackoverflow.com/questions/12084507/what-does-the-map-method-do-in-ruby]

### Also read
[http://www.railstips.org/blog/archives/2009/05/11/class-and-instance-methods-in-ruby/]
[http://rubyinrails.com/2014/06/05/rails-pluck-vs-select-map-collect/]
[https://hackhands.com/ruby-on-enums-queries-and-rails-4-1/]


### Testing approach
Vanilla TDD: test for each variation
Pass in (1) one relevant object, (2) zero relevant objects, (3) >1
relevant objects; pass in (4) one irrelevant object, (5) >1 irrelevant
objects.

To cushion that, add a guard clause to your function, e.g.
``` ruby
def foo(bar, baz)
  return nil unless foo && baz
  actual code
end
```
This way, I already guard against nil objects/ no objects being passed
in and don't need to test for that case.

From big to small: When starting out, there is nothing wrong with
writing an entire integration test. As your code gets more precise, you
can always jump in and move to unit tests only to speed up the test
suite.

### Performance improvement: *Memoization*
Scenario: You are running a method that includes a potentially slow
query over and over in your code. To cache the result the first time
around, memoization via `||=` comes into play. Best practice is to
separate out the exact operation into its own function:

``` ruby
class Company < ActiveRecord::Base
def current_budget
  @current_budget ||= calculate_budget(2015)
end

private

  def calculate_budget(budget_year)
    Foo.bar(budget_year)
  end

```

Note: if the function whose result is now cached in our instance
variable returns nil or false, there will not be a caching effect. (I.e,
if `Company.current_budget` had returned `false` or `nil` the last time around,
the application would run the `calculate_budget` function again when
calling `Company.current_budget`.

More detailed example:
[https://www.youtube.com/watch?v=lB_HS81yH94](Railscast #137)
[http://www.railway.at/articles/2008/09/20/a-guide-to-memoization/](Memo-what
blog post)

### Class and instance variables
First up, let's look at the beauty of instance variables: The idea is
that our `Halloween` class has a value for `date` attached. We can get
there either by `attr_accessor`ing a `:date` attribute - this lets us
get and set `@date` on `Halloween`. Yet, we can't just call
`Halloween.date` - since `attr_accessor` creates methods only on
instances of `Halloween`, we need to create a new one first and then
assign `date` to it: `Halloween.new.date = today`.

We can set the `attr_accessor` methods on the class level, as well:

``` ruby
class Halloween
  require 'date'

  class << self; attr_accessor :date end
  @date = Date.new(2015,10,31)
end

puts Halloween.date # => Oct 31, 2015
```

If you're worrying about inheritable attributes, e.g. for a subclass
that inherits from `Halloween`, then fret no more: Rails has features
for that. (Possibly to be covered elsewhere.)

### Enumerables: `select`
Or: How can I filter certain objects from an array?
Imagine we have an array of books, all with a title, author and
category. To go in and filter for a certain category, we can use the
beauty of `select`:

``` ruby
def all_from_category category
  @books.select do |book|
    book.category == category
  end
end
```

This way, calling `@books.all_from_category(:biography)` will take the
`@books` array and return an array composed just of those books that
have a category of `biography`. Nice!

### Logs
Easiest server log: ssh into server, then call `tail -f
log/production.log` for production emails.

### Truthy/falsey checks
To build a condition resting on a boolean attribute being `true`, it's
best to use a falsey check that works for all of `true`, `false` and
`nil`:
``` ruby
def set_checkbox
  unless @user.email_opt_out
end
```

### `remote: true`
The idea behind a `link_to` helper that uses `remote: true`: Hit the
designated controller action (you can even switch the HTTP method with
`method: :patch` and JQueryUJS will swap it for you) and don't render a
new page.
In `routes.rb`, add a
``` ruby
resources foo do
  member do
    patch :activate
  end
end
```

In the controller, remove all `redirect_to` directives and leave only
the actual change to the model you want to see. Lastly, set up a
corresponding JS view for the controller action, in this case
`activate.js.erb`. This will simply get loaded by JQuery UJS after it
hit the controller - use this to simulate the on-page behavior you would
have seen from having a new view rendered - `.hide()`, `.text('some
text')` etc.
Done!

### Ruby enumerables
Check separate folder for more details.
In short:
* `map`
`map` is a function that builds a new array. It then takes each element
of the provided array, applies the provided block to it and inserts the
return value of that particular element into the new array.

* `select` adds an additional check to `map` to see whether the return
  value is `true`. Only `true` values get added to the arrayich im Kalender an.

### Procs and lambdas
The basic idea: Pass around anonymous chunks of code in your
application, i.e. we're not defining an entire class or method here.

Procs get executed and return their result, which will even
override a wrapping method that calls the proc and follows up with a
`return` of its own - if the proc works, the proc return will be all
that's seen from the method.

Lambdas are less forgiving: Pass in more arguments than specified to a
proc and it will still return the result for however many arguments you
specified and discard the surplus. A lambda will raise an exception much like
a method and complain that you passed in the wrong number of arguments.
On the flipside, the lambda is just going to run in the order of things
and the wrapping code will continue afterwards.

Or put differently: `proc` behaves like a block, `lambda` behaves like a
method.

Also note that the `|a|` part in blocks or procs is actually the
argument(s) we're passing into the block.

Calling a proc works in different ways:
``` ruby
my_proc = proc do |a|
  puts "This is my proc and #{a} was passed to me."
end

my_proc.call(10)
my_proc.(20)
my_proc[30]
my_proc === 40
```
all work with the same effect.

### Procs, blocks, lambdas, continued


### STILL TO-DO
Teaching: The basics of programming always work well in combination with
context information on web servers, browsers, debugging.

After the first tries of running Ruby, a good next step is likely two
units on Ruby basics:
(1) on enumerables - getting everyone familiar with
creating and handling arrays and hashes in a practical context. Also:
possibly explain the use cases for methods, procs and lambdas (in a
beginner-friendly way).
(2) Ruby/ programming foundations: Why do we use classes? How do we use
them? What's the deal with methods, procs and lambdas? (But explain
inversely: "Let's make a method-like code block to do X. (...) OK, that
was a lambda!")
(3) handling file operations: Open an index.html file, add stuff to it,
write and save again. Serve HTML with Python server.
Bonus: Use Sinatra and the Twitter gem to get actual content into the
application. (Explain gem concept and `require ./`)
Bonus 2: json and Yaml as file formats.

Additional ground work:
(4) working with git and GitHub, including pull requests and feature
branches
(5) command-line basics: `cd`, `mv`, `mkdir`, `touch`, `cat`, `nano`/ `vim`,
`pwd`,  and
`bash` aliases (- do these work on Windows?)

Question: TDD could be interesting at this point to get the concept
across.

Intermediate: HTML/CSS, combined with SCSS via `compass`. Explain HTML5
and CSS3 as concepts. Introduce Foundation/ Bootstrap frameworks for
faster results.

Progression: Either Sinatra with subfolders and then on to Rails or
directly into Rails.
On foundations: Go deeper into best practices of OOD, instance vs. class
methods.

### Rspec / testing debug
Easy approach: add `pry` to Gemfile and set `binding.pry` within the
spec.
But what can we do when that doesn't catch the slipup? Watching the logs
is our way out:
* Open up a separate tab
* `tail -f log/test.log` to tail/follow the test.log file

Now, run the test again in the first tab and we'll see the entire server
log for our test, including possible errors like insufficient
permissions.

### Sys admin
To find out which unix group you belong to: `id [username]` will list
them all out. For instance, for Docker, it makes sense to add the
current user to the Docker usergroup, as well.

To add yourself to a group: `usermod -G
all,of,your,groups,incl,existing,ones` or on Ubuntu: `adduser [username]
[groupname]`.

To join a group without logging out and back in: `newgrp [groupname]`

### Navigation/ directories
Check out file sizes in directories: `du -ah` will show `disk usage` in
`human` readable form for `all` files.

File size on system level: `df -h` in root.

Master move: go back to the directory you were previously in with `cd
-`. Magic!

Zipping up files: `zip myzipfile.zip firstfile.foo secondfile.bar` will
zip up individual files. `zip -r myzippedfolder.zip` zips up the entire
folder. Copy to public folder and download.
Unzip: `unzip myzipfile.zip`

### File manipulation and creation and manual CSV parsing
The basis: an XLS file that we convert to CSV.
Our goal: parse the file into a handy-dandy array, then use the array
for more fun.

Step one:
``` ruby
array = []
file = File.open('myfile.csv', 'r') // for read-only access
  `file.each_line do |line|
  array << line.chomp.split
end
```

We can add some more Ruby magic to the processing line along the lines
of `line.split.map(&:to_i)` (- remember how `map` is basically the
super-code to apply a certain operation on each element as we cycle
through the block), or `line.split(";")[1]` to first split elements of
each line into sub-arrays and then only select the second element of
that array.

Step two:
If need be, we can clean up our array and remove, for example, a
trailing ";" on each element:
``` ruby
new_array = []
array.each do |a|
  new_array << a[0..-1]
end
```

Step three:
Transfer the file using `scp`: `scp myfile.name production:folder/`.

Step four:
Now reparse the file into an array and make use of it. To recreate a new
CSV from scratch, start with an empty string that we'll fill manually.

``` ruby
data = ""
array.each do |element|
  user = User.find_by(id: element)
  data << "#{user.name};#{user.email}\n"
end
```

Step five:
Take the string and write to file:
``` ruby
file = File.open('myexportfile.name', 'w') { |myfile| myfile << data }
```
and `scp` the bad boy back to local.
Done!

## Serving HTML locally
Intricate route: Use `gulp` to preprocess files.
Easy way: start a local webserver in Python `python -m SimpleHTTPServer`
or Ruby `ruby -run -e httpd . --port=1337`.
