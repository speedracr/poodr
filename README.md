# Here be object-oriented code.

## Ruby-related
### Splat operator
This is one that takes getting used to: the * splat operator adds spice
to methods and calls.

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
