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

## gsub
Ha, this is easy: to strip out all characters except, e.g.,
alphanumerics: `foo.gsub(^a-zA-Z0-9, '')`. Check the little ^, which is
regex for "apply to everything **but** the following".
