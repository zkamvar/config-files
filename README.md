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

### Changing colors

I previously had some keyboard mappings to change colors in kitty, but it got
more complicated with [the themes kitten](https://sw.kovidgoyal.net/kitty/kittens/themes/) 
where it would modify the `kitty/kitty.conf` file to include the following lines:

```
# BEGIN_KITTY_THEME
# <theme name>
include current-theme.conf
# END_KITTY_THEME
```

Every time I changed the theme, my kitty conf would be changed in git's eyes.
[The way I rectified this was to use git
filters](https://stackoverflow.com/a/5272721/2752888) which would act on the
`kitty/kitty.conf` file by removing those lines alltogether:

In `.git/config`

```
[filter "badkitty"]
  clean=sed '/BEGIN_KITTY_THEME/,/END_KITTY_THEME/ d'
  smudge=sed '/BEGIN_KITTY_THEME/,/END_KITTY_THEME/ d'
```

In `.git/info/attributes`

```
kitty/kitty.conf filter=badkitty
```
