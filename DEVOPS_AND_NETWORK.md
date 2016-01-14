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

## shell
To list all files:
`ls -a`
Human-readable file size:
`ls -l`
Sort by time:
`ls -t`
- all of them can be combined, too: `ls -lat`

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

### Docker and Postgres
If the application can't connect to Postgres container
("PG::ConnectionBad: could not connect to server: Connection refused")
when running in `docker-compose up`: make sure `links` includes
`postgresql` container, then throw-away running Docker containers of
that app and restart them from scratch.

### LAN tricks
You have a machine that you connect to via an open port from another
server? In that case, connecting from the server to the machine using
`ssh -p [port number] -A foo@bar.server` will get you there (`-A`
forwards the SSH certificate you were using to log into the server, so
that it doesn't use the middleman-root user's certificate but your
local, personal one instead.

Want to set up a good ol' local SSH connection? Easy:
1) Find out IP address of machine you want to connect to with
`ifconfig`. It'll likely be `192.168.FOO.BAR`.
2) Open `~/.ssh/config` on your own machine.
3) Add a new entry like so:
```
Host supermachine
  HostName 192.168.FOO.BAR
  User foo # => foo@thinkcenter
  PubKeyAuthentication yes
  ForwardAgent yes
  IdentityFile ~/.ssh/id_rsa
  ServerAliveInterval 60
  ServerAliveCountMax 15
```
4) Connect using `ssh supermachine`.

