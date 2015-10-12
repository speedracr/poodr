# git Notes

## Issue: There is a messed-file in my commit!
Through uncareful merging, you just introduced changes into a file that
weren't meant to be part of the commit, yet it's too late and everything
is already packaged up.

Solution: **checkout a single file from master** with `git checkout
master -- file/name`

If it's `schema.rb`, run `RAILS_ENV=test ./bootstrap.sh` to update the
schema if your environment works that way. Alternatively, `rake
db:migrate` again to go through your migrations and update `schema.rb`

## Oh wonders: `git add -p`
Let's assume we made changes to a file and later on added more changes
for a different purpose. Well, when we add `-p` to `git add`, we can
select individual "hunks" of code to be added to the index; the
remainder stays unstaged and we can `git stash branch` them out
afterwards.

