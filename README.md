# ~/bin/
A home for my squigglebin; all one-off utilities not needing their own dedicated repo.


## conf
Config files aren't really in a standardized place.

Sometimes it's _/etc/_, oftentimes a dotfile in your homedir, other times under _~/.config_.

`conf` assigns short names to each dotfile for easier editing. E.g.,

```bash
# create entry for your ~/.bashrc
conf set bash ~/.bashrc

# launch in $EDITOR
conf edit bash

# create group for related configs
conf set nvim.colors '~/.config/nvim/colors/*'

# launch in $EDITOR, supplying additional arguments
conf edit nvim.colors -O3
```


## roam
Laptop is bad at WAP handoffs between my bedroom and office.
Needed a way to force it over to the correct one.

This gives a quick CLI, TUI, or graphical approach.


## d
Never been sold on fast directory switching in bash.
It is common for me, when working on a project, to toggle frequently between 2-3 directories.

`pushd` and `popd` take things most of the way, but have shortcomings.

This is an experiment to play around with alternate forms of directory switching.
It's definitely not there yet--as evidenced by my own lack of use.
But it's an interesting start.
