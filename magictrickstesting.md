# Sandi Metz: The Magic Tricks of Testing
Link: [https://www.youtube.com/watch?v=URSWYvyc42M](Rails Conf 2013 talk
/ YouTube)

## Unit tests
Goals: thorough, stable, fast, few
Get there with clarity! Focus on the messages.

## Best practices
* Conflate commands (returns nothing, does something) and queries
  (return something, do nothing) at your own peril: Not ideal but hard
to avoid, and one of the foundations for good tests is good separation
of the two.

* Don't test private methods (generally) - it binds you to the old code.
Alternative: Keep private method specs and comment in: Delete if this
breaks.

* Generally, it's the receiving function's job to make sure it performs.

* The only outgoing functions to test: Commands! (not queries) But: make
  sure you're not testing whether something eventually gets changed in
the DB, because that is most likely not the function's responsibility.
