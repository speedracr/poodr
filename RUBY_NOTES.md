# Ruby notes

## Array handling
If you have a bunch of values in an array, `pop`/`push` and
`shift`/`unshift` will help:

Ruby's `pop`/`push` work on the end of the array (last in, first out),
meaning that `Array.pop` will remove the last item from the array
(permanently!) and return it, while `Array.push('foo')` adds `'foo'` to
the end of the array.

If you need the start, use `shift`/`unshift`: `Array.shift` will remove
the first element of the array and return it, `Array.unshift('foo')`
adds `'foo'` to the front. Magic!

To remove a certain value (all occurences!) from our array, we can hit
`Array.delete("")` or `Array = Array - [""]` and clean up.

## Array searching
So you have an array with loads of content and are looking for a
particular entry? Do this:
``` ruby
result = Array.find { |e| e == 'foo' }

# or for Structs, for example:
result = Array.find { |e| e.id == 42 }
```

Great example why ActiveRecord is useful: plain Ruby doesn't know about
`find_by(id: 42)`, whereas a Rails app with ActiveRecord does.

One step further: you can also have Ruby return the result as an object
with `select`:
``` ruby
huge_array.select { |e| e.include?('foo') } # => '["foo;bar;123",
"quix;foo;456"]
```
Important: this always returns an array, so even if you have just one
result, you'll need to select it via:
``` ruby
result = array.select { |a| a.id == 42 }
result[0]['first_name']
```

## gsub
Ha, this is easy: to strip out all characters except, e.g.,
alphanumerics: `foo.gsub(^a-zA-Z0-9, '')`. Check the little ^, which is
regex for "apply to everything **but** the following".

## Histogram example
Set up a new hash, with default value 0 to count up:
`h = Hash.new(0)`

Now, iterate over a list, array, ... and for each value, set a key in
the hash and add 1 to its value. Then, sort the hash by number and
reverse:

``` ruby
h = Hash.new(0)
Array.each { |a| h[a] += 1 }
h = h.sort_by { |k, v| v }
h.reverse!
```


