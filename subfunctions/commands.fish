#Parse flags and declare variables
argparse e/edit u/update -- $argv
set -l local_pages (status filename)/pages/
set -l global_pages $HOME/.tldr/cache/pages/
set -l {,(status filename | command xargs dirname)/}command_list

# Update command list
test -s $command_list -o -n "$_flag_update"
source (status filename | command xargs dirname)/update.fish

# Edit command pages
if set --query _flag_edit
  if test -z "$argv"
    err "percol: Flag |-e/--edit| requires arguments"
    exit 1
  end
  for page in $argv

    # Test if the command page doesn't exist
    command find "$local_pages" -type f \
    | string match -e "/$page.md"
    or command find "$global_pages" -type f \
    | string match -e "/$page.md"
    if test $status = 1
      wrn "No page found for |$page|"
      read -n 1 -P "Create one? [y/n]:" \
      | string match -qi y
      or continue

      # Create a command page
      echo -e "# $page\n" > "$local_pages/$page.md"
      command cat (status filename | command xargs dirname)/command_page_template.md \
      >> "$local_pages/$page.md"

    # Or instead, if there's a global copy of the command page, make a local copy
    else if not test -s "$local_pages/$page"
      command cp (command find "$global_pages" -type f \
      | string match -e "/$page.md") "$local_pages/$page"
    end

    # Edit a local copy of the command page and update the command list
    sensible-editor "$local_pages/$page"
  end
  source (status filename | command xargs dirname)/update.fish

# Browse command list and load a selected command into the command line
else
  cat "$command_list" \
  | command percol --query "$argv" --match-method regex \
  | string match -r '^[^(]+(?= \()' \
  | read command
  or exit 1
  
  # Load the selected command into the command line
  commandline $command

  # Set the cursor position over the first variable location
  commandline -C (string match -r '^((?!{{).)+' $command \
  | read \
  | command wc --chars)
end
