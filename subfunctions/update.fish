#!/usr/bin/fish
# Determine kernel
set -l kernel common
if command uname -s | string match -qi darwin
  set --append kernel osx
else if command uname -s | string match -qir "(cygwin|windows)"
  set --append kernel windows linux
else if command uname -s | string match -qi sunos
  set --append kernel sunos
else
  set --append kernel linux
end

# List commands available for the given system
test -d "$HOME/.tldr/cache/pages"
or command tldr update
set -l pages (command realpath $HOME/.tldr/cache/pages/{$kernel}/*)

# See if the current command list is up to date with the results from the query
set -l {,(command dirname (status filename))/}command_list
string match -q (command tail -1 $command_list 2>/dev/null) \
(ll -t $pages | grep -m1 -oP '\S+\s+\d+\s+\d{2}:\d{2}')
and exit 0

# Generate an updated command list
wrn "Updating command list. This might take a minute."
set -l tmp (mktemp)
for page in $pages

  # Prefer local copies of the command pages.
  test -s (command dirname (status filename))/pages/(command basename $page)
  and set page (command dirname (status filename))/pages/(command basename $page)

  # Add command name and its description
  set -l specifier (command grep -hoP '(?<=^# ).*' $page)
  set -l description (command grep -hoP '(?<=^> ).*' $page)
  echo "$specifier ($description)" >> $tmp

  # Add example usages and their descriptions
  set -l commands (command grep -hoP '(?<=^`).*(?=`$)' $page)
  set -l descriptions (command grep -hoP '(?<=^- ).*(?=:$)' $page)
  for i in (command seq (count $commands))
    echo "$commands[$i] ($descriptions[$i])" >> $tmp
  end
end

# Overwrite previous command list
ls -lt $pages | grep -oP '\S+\s+\d+\s+\d{2}:\d{2}' -m 1  >> $tmp
command mv -f $tmp $command_list
win "Command list succesfully updated"
