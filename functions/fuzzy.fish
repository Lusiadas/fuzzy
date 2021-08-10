function fuzzy -d "Fuzzy select commands, files or processes"
  set -l subfunctions (status filename | command xargs dirname)/../subfunctions

  # Source dependencies
  source $subfunctions/dependency.fish -n $cmd \
  -p percol -N tldr file mlocate sensible-utils (type -qf termux-info; or echo xdg-utils)

  # Parse options
  if argparse -n percol -x (string join ' -x ' o,c,e,u,y,t,h {c,e,u},y,t,f,h | string split ' ') 'c/commands' 'e/edit' 'u/update' 'y/history' 't/terminate' 'f/file' 'o/open' 'h/help' -- $argv 2>&1 | read err
    err $err
    return 1
  end

  # Execute options
  if set --query _flag_help
    source (status filename | command xargs dirname)/../subfunctions/instructions.fish
    not string length (set --names | string match -r '_flag_.+')$argv
    return $status
  else if set --query _flag_history
    commandline (history | command percol --query "$argv")
  else if set --query _flag_terminate
    command ps ax -o pid,command \
    | string match -ve percol \
    | command percol --query "$argv" \
    | command awk '{print $1}' \
    | command xargs kill 2>/dev/null
  else if set --query _flag_file
    source $subfunctions/file.fish $_flag_open $argv
  else
    source $subfunctions/commands.fish $_flag_edit $_flag_update $argv
  end
end
