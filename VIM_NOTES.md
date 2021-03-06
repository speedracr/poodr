# vim notes
? toggle help

## File access
Leader-b: show recently opened files
(Leader-)i: open file from NERDTree in new split
(Leader-)s: open file from NERDTree in new vsplit
Ctrp-p: index all files, then magic search for file names
Search for a text pattern in currently open files: `/foo`
Search case sensitive/insensitive: `/\cfoo` for insensitive (Janus
default), `/\Cfoo` for sensitive.
Switch off highlighting after search: <leader> hs

## Power moves
On a file name: g-f will *go* to *file*
Go back: Ctrl-Shift-^ (Ctrl-~) or Ctrl-O
Go forward: Ctrl-I (inverse of Ctrl-O)
List all files in a directory: Select file in NERDTree, then `:e` +
NERDTree: reset root directory shown with `C`, go up one directory with
`u` / `U`.
`Ctrl-p` to paste in the current directory. Enter and voila, the file
list appears in the main window.
Auto-format mangled up text (e.g. crazy indentations): mark up lines and
then hit `=` - voila, all nicely formatted..
Search for word under cursor: toggle `hlsearch` with `<leader> hs`, then
hit `*` when your cursor is over a word. Voila, this will highlight all
occurences in the document. Toggle off with `<leader> hs`.

## Text manipulation
ddp: delete line, then insert below (swaps lines)
ddP: delete line, then insert above
Shift-a, Shift-i Shift-0: insert text before first/ last character of
line
Switch to uppercase/lowercase: Mark up text in visual mode, then `u` for
downcase or `U` for upcasing the selected text.

## Registers
in general: regs save all snipped text, can be inserted via "[register]p
for copy/paste: mark text for copy, copy with `yy`. Go to paste target,
insert text with `"0p` (register > 0 > paste)

## Window manipulation
Resize window: Ctrl-w and <> to increase/decrease width
Minimize all other windows, except current: `<Cr-W>o` (toggles)
Show NERD Tree Leader-n
Swap windows: Ctrl-w and Ctrl-x / Ctrl-r (swap/rotate)

## Moving the screen and cursor
Ctrl-e, y: Move the screen up/down by one line, without change to cursor
Ctr-f, b: Move the screen up/down by one page
Ctrl-u, d: Move the screen up/down by half a page
H, M, L: Move cursor to first, middle, last line
zz, zb, zt: Keeps cursor, shifts current line to middle, bottom, top of
screen

## Remap vim via dotfiles / .vimrc
Remap save action to double; : `noremap ;; :update<CR>`
Remap ESC action to jj in insert mode: `imap jj <ESC>`
Remap `qq` to toggle `qa` quit all: `:cabbrev qq qa`, or shorter: `:ca`

## Search and replace
File search: If you have `ack` installed, then <Leader> `f` will bring
up a file search box.
Search for a string and replace:
`:s/search` on current line
`:%s/search` in the whole document
`:%s/search/replace/g` updates all occurences in the document
> `g` meaning "global", i.e. all occurences will also be replaced.
> `gc` will ask for confirmation
> `gi` will make the operation case insensitive
> `gI` will make the operation case sensitive

## Save changes in new file
So you made changes in your file and don't want to overwrite the
original? Easy: `:w newfile.foo` will create a new file from your
current status. Warning: Close the current file and open the new one,
since another `:w` would then indeed overwrite the file.
