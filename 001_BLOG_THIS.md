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

## Rspec prepend_view_path
So we're separating the backoffice /admin part from the end user part.
Straight forward enough with spliting the application controller and
adding a `UserApplicationController` and a
`BackofficeApplicationController`, and even Devise plays along once you
configure it correctly in the routes. To use different templates, we're
using the `prepend_view_path` method, so that Rails looks in
`user/views/devise` and `backoffice/views/devise` rather than just
`views` directory.
Except: we have a nice view spec that now breaks, because it doesn't go
along with prepending. (The reason for this, as I learned, is rspec's
fake own controller that doesn't give a rat's ass about our nicely
constructed `backoffice_sessions_controller`.):
``` ruby
NoMethodError: undefined method `prepend_view_path' for #<RSpec::ExampleGroups::>
```

Solution: rspec provides a (new) way of modifying the view path (cf.
https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs/views-are-stubbed-by-default)
so that we can write our code as follows:
``` ruby
describe 'devise/shared/_links.html.haml', :dbless do
# the line below will render the default devise views, regardless of our
# nicely modified session and registration controllers
let(:rendered) { render 'devise/shared/links' }

before do
  controller.prepend_view_path 'app/user/views' # << this fixes that!
  allow(view).to receive(:resource_name) { :user }
  ...
end

it 'shows the sign up link' do
  href = new_user_registration_path
  expect(rendered).to have_css "a[href='#{href}']"
end

```

