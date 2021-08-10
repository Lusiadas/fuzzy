source $path/subfunctions/dependency.fish -rp percol \
-N tldr file mlocate sensible-utils \
(type -qf termux-info; or echo xdg-utils)
