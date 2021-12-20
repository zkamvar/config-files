# Zhian's Config Files (dotfiles)

To use these files, clone this repo into a place on your computer and then 
symlink them to your home directory. For example, here's how to link the bash
prompt file:

```sh
ln -s path/to/config-files/.bash_prompt .bash_prompt
```

To use the `.bash_` dotfiles in your `.bashrc` or `.bash_profile`, you can load
them with:

```bash
if [ -f ${HOME}/.bash_prompt ]; then
  . ${HOME}/.bash_prompt
fi
```

## .gitconfig

To use the .gitconfig in your own .gitconfig, use the `[include]` directive:

```toml
[include]
  /path/to/config-files/.gitconfig
``` 

## kitty

The kitty config is put in `~/.config/kitty/`
