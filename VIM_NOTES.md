# vim notes
? toggle help

## File access
Leader-b: show recently opened files
(Leader-)i: open file from NERDTree in new split
(Leader-)s: open file from NERDTree in new vsplit
Ctrp-p: index all files, then magic search for file names
Search for a text pattern in currently open files: /[foo]
Switch off highlighting after search: <leader>h > s

## Power moves
On a file name: g-f will *go* to *file*
Go back: Ctrl-Shift-^ (Ctrl-~) or Ctrl-O
Go forward: Ctrl-I (inverse of Ctrl-O)

## Text manipulation
ddp: delete line, then insert below (swaps lines)
ddP: delete line, then insert above
Shift-a, Shift-i Shift-0: insert text before first/ last character of
line

## Registers
in general: regs save all snipped text, can be inserted via "[register]p
for copy/paste: mark text for copy, copy with `yy`. Go to paste target,
insert text with `"0p` (register > 0 > paste)

## Window manipulation
Resize window: Ctrl-w and <> to increase/decrease width
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
