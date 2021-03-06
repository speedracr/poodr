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

## Exclude files
Well, there is `.gitignore`. For even more, check out the
`.git/info/excludes` file in your repository - excellent to add a
configuration that isn't mirrored back to remote.
Thirdly, `.gitconfig` in the home directory lets you set a global
`~/.gitignore` with files to always exclude from git management.

## reverting commits
`git reset HEAD^` will revert to the previous commit and is the
equivalent of `git reset HEAD~1`. `git reset HEAD~2`
and so on will go back further.
When pushing a reverted branch back to remote (i.e., the new version
that we reverted from is already on remote), remote will reject this
push since it's less current than what it already has. The solution:
`git push -f` will force push the commit and reset remote, as well.


## Rebasing
Big topic, but let's start small: we have a branch and one of the
commits contains sensitive info. If this is a private repo and no one
else has pulled the branch, we can get away with rebasing the branch and
squashing the fatal commit and a subsequent fixing commit into one:

`git rebase -i master` loads the interactive rebasing, starting out from
the changes made to master.
Next, we replace `pick` with `s[quash]` for all commits that we want to
bundle into one big (and cleaned-up) commit.
Save and edit the commit message.
If the branch is already on remote: `git push -f` will force-update
the remote repo and in effect rewrite the repo's history. This would be
mostly ineffective for a public repo or one where the offending branch
already lives on other machines, but in this case, it's doable.

## Rebasing in detail
A starting note: "fast forwarding" actually means that git just lets
HEAD on the master branch point to the most recent commit of the feature
branch, effectively sticking the `HEAD master` label onto it. This
happens when there are no merge conflicts and no other updates to
`master`, e.g. when you merge a feature branch into `master` as part of
a personal project.

A three-way or **recursive** merge occurs when we need to consolidate
updates to `master` that happened while you were working on your feature
branch. For that, git needs to create a new commit that unites your own
feature branch update with the update to master that came after you
branched off.

Now rebasing actually goes in and changes the history of your repo,
although in a mostly innocent way: instead of going all the way of a
recursive merge, imagine you had branched off *after* the update to
master. Then, git could simply fast-forward `HEAD` and be done. With
rebase, we're simply setting the base (or root -) commit for the
feature branch-off to be just that commit that updated master.

Operationally: on feature branch, execute `git rebase [root branch for
rebase, most likely master]`. Done.

### Rebase guidelines
* Never rebase a branch you've made available publicly: Someone else may
  have pulled it already and they won't be rebased with you, making
  merges down the road pretty nerve-racking.
* There is no other guideline.
