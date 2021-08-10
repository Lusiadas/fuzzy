set -l cmd (status filename | command xargs basename | cut -f 1 -d '.')
complete -c $cmd -n 'not contains_opts' -s y -l history \
-d 'search for commands in your history'
complete -c $cmd -n 'not contains_opts' -s t -l terminate \
-d 'search for processes to terminate'
complete -c $cmd -n 'not contains_opts' -s f -l file \
-d 'search for a file'
complete -c $cmd -n 'contains_opts f file' -s o -l open \
-d 'open file with default application'
complete -c $cmd -n 'not contains_opts' -s c -l commands \
-d 'search for commandline examples'
complete -xc $cmd -n 'contains_opts c commands' -s u -l update \
-d 'update command list'
complete -xc $cmd -n 'contains_opts c commands' -s e -l edit \
-d 'edit a command page'
