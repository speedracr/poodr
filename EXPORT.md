# How to export pinpoint data from the Rails console

1) Set up the criteria - a good basis to start from are participation
ids that you load into an array.

2) Set up your intermediary Struct:
``` ruby
class Person < Struct.new(:attribute1, :attribute2)
end
```

This way, you can save the retrieved information for each user in a
lookup-friendly way (here: `Person.first.attribute11).

3) Fill the data:
Iterate over your id-based array and for each record, save the resulting
information to a newly created intermediary object and finally move the
intermediary into a new array.

```ruby
people = []

array.each do |e|
  p = Person.new
  record = Record.unscoped.where(id: e).first
  p.attribute1 = record.foo
  p.attribute2 = record.bar
  people << p
end
```

4) Export to CSV
Finally, iterate over all elements in the saved array and create a
string line:

```ruby
result = ""
result << "header;foo;bar\n"

people.each do |p|
  result << "#{p.attribute1};#{p.attribute2}\n}"
end

file = File.open('export.csv', 'w') { |my_file| my_file << result }
```
