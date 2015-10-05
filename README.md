# Here be object-oriented code.

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
