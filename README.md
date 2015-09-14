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
