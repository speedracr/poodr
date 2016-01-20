# CoffeeScript low-down
Basic idea: never semi-colons, take out curly braces (at least for
syntax), reduce superfluous terms like `function`.

In practice
## Parentheses
1) To set up a function without arguments:
```
noArg1 = ->
  console.log("Hello.")
```

2) Or:
```
noArg2 = () ->
  console.log "Hello."
```

Both work. With arguments:
3)
```
withArg = (myArg) ->
  console.log(myArg)
```

Now calling a function however always requires parentheses
or arguments:
```
noArg1()
noArg2()
withArg "hello" / withArg("hello")
```

## Commas
Not needed as much - CS will go by new lines and whitespace to identify
elements, e.g.:
```
someObject = {conf: "RailsConf", talk: "CoffeeScript"}

# same as
someObject =
  conf: "RailsConf"
  talk: "CoffeeScript"
```

## Heredocs
Interesting little fellow: using `"""`, we can set up large amounts of
text to be used in a variable, e.g.:
```
html = """
  <div class="superlong" id="exists">
    <hr>
    <p> More text written by #{author}. </p>
  </div>
"""
```

## Bound functions
We can pass around functions as objects and preserve scope with `=>`
("fat arrow")

Concretely:
```
class User
  constructor: (@name) ->
  sayHi: =>
    console.log "Hello #{@name}"

bob = new User('bob')
mary = new User('mary')

log = (callback)->
  console.log "about to execute callback"
  callback()
  console.log "...executed callback"

log(bob.sayHi)
log(mary.sayHi)
```

## Neat trick
Existential operator only kicks in when the important part exists:
```
console?.log "foo"
```
only prints if console exists. (Great for IE!)
