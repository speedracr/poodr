# This is what makes applications easy to change - Classes
## Methods
Hey, these are defined in classes. As much as you want to group them all correctly: impossible to be 100% right.

** Idea: Organize code in a way that makes change easy **
'Easy' meaning:
- absence of unexpected side effects of changes
- small change in requirements = small change in code
- easy reuse of existing code
- an easy way to change the application is adding code that again is easy to change

, corresponding with these qualities:
- transparent: obvious consequences
- reasonable (cost of change)
- (re)usable code chunks
- exemplary

TRUE! code.

## Classes
A class has a single responsibility. Period.
Once you have everything sorted out: Is this *the* best way to organize your code? Well: It depends.
But what doesn't depend is single responsibility. This turns the atoms of your application into building blocks, selectable one by one.
If classes don't have single responsibilities, you're not going to reuse them, and instead will duplicate your code.
Also: all of a sudden, every class that isn't SR now has multiple reasons to change, namely one per responsibility.
So ask your classes for their methods: Mr. Gear, what is your gear_inches? Well, that is one ill-fitting question to ask of Mr. Gear.
If a class is easy to describe without "ands", it is SR or 'highly cohesive'.
Also: classes can have instance variables, in the case of our `Gear`
class `chainring` and `cog`, both created with the wrapper method of
`attr_accessor`.

Dependencies = what other classes depend on this class doing its work in the expected way?

### Principle 1: Depend on behavior, not data
  Wrap the instance variable inside of an accessor method. That way, the method can handle any modifications to the variable down the road, where otherwise you would have to add the modification everywhere if you referred to the instance variable itself.

## Big points
OOP may look to focus on objects, but following the Sandi Metz approach,
looking at messages can be the better way: single responsibility is
implemented not by the number of classes or objects within a method, but
by the type of message(s) that the class responds to and what it
responds with.

(Now to take that insight and apply it to shuffling Rails chunks is a
whole new story, of course.)
