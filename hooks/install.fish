command wget -qO $path/subfunctions/dependency.fish \
https://gitlab.com/argonautica/dependency/raw/master/dependency.fish
source $path/subfunctions/dependency.fish -n $package \
-p percol -N tldr file mlocate sensible-utils \
(type -qf termux-info; or echo xdg-utils)
