# Rails notes
## Quirks and tricks in Rails

### Date/Time
#### Calculate a person's age from birthday
Get their birthday as `Date` object. Test: `bday.year` returns the year
they were born in.

Get today as `Date` object: `now = Time.zone.now.to_date` (or even just
`Date.today`)

Calculate year difference and check if birthday already happened this year.
If not, subtract one year:
``` ruby
age = now.year - bday.year
if now.month > bday.month || now.month == bday.month && now.day >= bday.day
  age - 1
else
  age
```
Or short:
``` ruby
def age(birthday)
  Date.today.year - birthday.year - ((Date.today.month > birthday.month
  || (Date.today.month == birthday.month && Date.today.day >=
  birthday.day)) ? 0 : 1)
end
```


### Minis
`.change`: if we call an object with `.change`, we can simply pass in a
new value. Example: Change a birthday date to be the same date in the
current year:
`bday.to_date.change(year: Date.today.year)` (- will break for leap year
birthdays)
