set -l bld (set_color 00afff -o)
set -l reg (set_color normal)
set -l instructions $bld"fuzzy

"$bld"DESCRIPTION

Select commands, files, or processes using percol's fuzzy selection.

"$bld"OPTIONS

"$bld"fuzzy "$reg" -c/--commands

Search for examples of command line usage, this is the default option. It also has two suboptions:

"$bld"fuzzy --commands "$reg" -u/--update

Update the command list from where to draw examples from.

"$bld"fuzzy --commands "$reg" -e/--editor

Modify, or create, a page with usage examples of a given command.

"$bld"fuzzy "$reg" -y/--history

Search for commands in your history.

"$bld"fuzzy "$reg" -t/--terminate

Search for processes to terminate.

"$bld"fuzzy "$reg" -o/--open


