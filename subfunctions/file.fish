argparse 'o/open' -- $argv

# Find files matching passed argument
if test -z "$argv"
  err "percol: No argument passed"
  exit 1
else if not test -f "$argv"
  set query (command locate $argv)
  for i in (count $query \
  | command xargs seq 1 \
  | command tac)
    string match -qvr '/(.git|Trash)/' $query[$i]
    and test -f $query[$i]
    and continue
    set --erase query[$i]
  end
  if test -z "$query"
    err "percol: No file found for pattern |$argv|"
    exit 1
  end
  set argv (command printf '%s\n' $query \
  | command percol --query "$argv")
end

# Either display the file's name or open it
if not set --query _flag_open
  echo $argv
else if command file $argv | string match -qir ': html[^:]+$'
  command sensible-browser "$argv"
  or command xdg-open "$argv"
else if file $argv | string match -qr 'text$'
  command sensible-editor "$argv"
  or command xdg-open "$argv"
else
  command xdg-open "$argv"
end
