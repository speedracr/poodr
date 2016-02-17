# Blog this!

Haml trick: string interpolation for Rails helpers
```
%meta{ charset: 'UTF-8' }
%meta{ name: 'viewport', content: 'width=device-width,
  initial-scale=1.0' }
%link{ rel: 'icon', type: 'image/png', href:
    "#{image_path('backoffice/favicon_gf.ico')}" }
%title
  EntscheiderClub: Projektadminbereich
```
totally inserts an image.
Search terms: haml href rails asset helper image helper


## Heroku error
You get this (on Ubuntu/ Docker):
```
root@c8faef5872b2:/mnt# heroku run
!    `run` is not a heroku command.
!    Perhaps you meant `-h`, `2fa`, `auth`, `join`, `open`, `orgs`,
`pg`, `ps` or `rake`.
!    See `heroku help` for a list of available commands.
```

When trying to reinstall Heroku toolbelt, npm fails.
Solution: remove `.heroku` folder from root directory (`rm -rf
~/.heroku`), then try `heroku run irb` again.
Fixed.

