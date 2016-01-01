# Devops

## Server setup
On a fresh install, this will get you going:

**`sudo`**
* system update: `apt-get update`
* switch to super-user status with `su -` and add `sudo` with `apt-get
install sudo`.
* add user with root privileges (which again you can summon with `su -`
  or `sudo` when needed): `adduser [username] sudo`

## Network jiujitus
Unix machines:
`traceroute www.foo.bar` will trace-route the request.
`host www.foo.bar` will resolve the URL and shows both the actual IP
server address and possible aliases.

## Environment setup
`PATH` gets loaded via the shell initialization, meaning we can add
items to our `$PATH` via `.zshrc'. (Items on the path are separated
using `:`)
Interestingly, `$PATH` gets evaluated left to right, so whatever command
comes up first will take precedence. In the case of `rbenv`, we actually
want it to come last and can place it at the end of `.zshrc`, just to be sure.

Now to print out or execute a certain command on loading of the shell,
we can `eval` the command in our `.zshrc` like so:
`eval "whoami && ruby -v"`
In the case of `rbenv`, `eval "$(rbenv init -)"' apparently initializes
`rbenv` and lets us use shims and autocomplete.

## Re-login to shell
Once you've updated your path, use `exec $SHELL --login` to load a new
shell session using the new path setting.
