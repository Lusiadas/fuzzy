bind \eh 'fuzzy --history (commandline)'
bind \et 'fuzzy --terminate (commandline); commandline ""'
bind \eo 'fuzzy --file --open (commandline); commandline ""'
bind \ec \
'if commandline | string match -qr "\{\{[^{}]+\}\}"
  set -l pos (math (commandline \
  | string match -r "^[^{]+" \
  | command wc -m) -1)
  commandline (commandline | string replace -r "\{\{[^{}]+\}\}" "")
  commandline --cursor $pos
else
  fuzzy --commands (commandline)
end
'
