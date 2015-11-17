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
