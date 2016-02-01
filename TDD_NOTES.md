# TDD: Integration tests are a scam - Rainsberger
Corollary: Testing is often really just design.

## Definition
Any test that depends on many bits and pieces all working together. Or
in other words: An integration test is a test that when it fails, I
can't point the finger to just one part and say, "This is the culprit".
(A good test is exactly the opposite: Every test failure is the result
of a single problem. It just so happens you can only do this with unit
tests, or as Rainsberger calls them: isolated tests.)

## Basics
So why not write *just* isolated tests? Because the interaction can also
be the source of a bug - which we'll only find when running the entire
system together.

If the design of the code has problems, then it will also be hard to
write the small, isolated tests that we're looking for. In other words:
tiny tests are a good indicator, whereas if I need 25 lines just to set
up a test, it may have too much interaction with the outside world.


