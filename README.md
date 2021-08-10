# fuzzy

[![GPL License](https://img.shields.io/badge/license-GPL-blue.svg?longCache=true&style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.7.1-blue.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>

## Description

A tool to [fuzzy search](https://en.wikipedia.org/wiki/Approximate_string_matching) commands, files, or processes based on [percol](https://github.com/mooz/percol), the simplistic interactive filtering tool.

## Additional options

`-y/--history`

Search for a command in your history and set it as the current command line

`-t/--terminate`

Search current processes, and terminate those selected.

`-f/--file`

Search for a file and print its full path.

`-o/--open`

Combined with `-f/--file`, open selected file with the default application for it's format.

`-c/--commands`

Search for examples of command line usage. It also has two suboptions:

- `-u/--update`: Update the command list from where to draw examples from
- `-e/--editor`: Modify, or create, a page with usage examples of a given command.

## Install

```fish
omf repositories add https://gitlab.com/argonautica/argonautica 
omf install fuzzy
```

## Dependencies

> If any of the following dependencies isn't installed, upon installing fuzzy you'll be prompted to install them.

`percol tldr curl mlocate file sensible-utils xdg-open feedback contains_opts`

## Optional configurations

### Keybindings

By default, this script binds Alt+H, Alt+T, Alt+O and Alt+C to the additional fish options, passing the current command line as an argument.

```
bind \eh 'fuzzy --history (commandline)'
bind \et 'fuzzy --terminate (commandline); commandline ""'
bind \eo 'fuzzy --file --open (commandline); commandline ""'
bind \ec 'fuzzy --commands'
```

Alt+C has a double function: At first, it passes the content of the current command line to `percol --comands`. After selecting an option from `percol --comands`, it jumps between spaces to be filled in with arguments.

To change these keybindings, see `man bind`, and modify the file `$HOME/.local/share/omf/pkg/percol_utils/key_bindings.fish`.
