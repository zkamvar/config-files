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

## neo vim

As mentioned [in my colorschemes blog
post](https://zkamvar.netlify.app/blog/neovim-colorscheme/), I use
[LazyVim](https://www.lazyvim.org/) for this project. This lives in
[lazy-nvim](lazy-nvim/), which is symlinked to my `~/.config/nvim` folder (I
had migrated with
[commit a714e5e8](https://codeberg.org/zkamvar/config-files/commit/a714e5e8c90a2cad9e2550cde8843382ba2f13bd))
and switched my symlink from my [`nvim/`](nvim) to lazy-nvim.

```sh
$ ls -larth ~/.config
total 0
drwxr-xr-x  3 resu puorg   96 Apr  5 13:35 uv
drwxr-x--x  4 resu puorg  128 Apr  7 16:59 gh
drwxr-xr-x  7 resu puorg  224 May  3 07:57 fish
drwxr-xr-x  3 resu puorg   96 Jun 21 15:28 air
drwxr-xr-x  8 resu puorg  256 Jul 31 16:20 kitty
lrwxr-xr-x  1 resu puorg   43 Aug  1 08:08 nvim.bak -> /path/to/config-files/nvim/
lrwxr-xr-x  1 resu puorg   48 Aug  1 09:56 nvim -> /path/to/config-files/lazy-nvim/
drwxr-xr-x  9 resu puorg  288 Aug  1 09:56 .
drwxr-x--- 47 resu puorg 1.5K Sep 10 16:00 ..
```

### Historical notes

I started building the `.vimrc` file when I was using pure vim. At some point,
I switched to NeoVim because there was a bug with certain characters that caused
vim to crash (I cannot remember exactly why).

NeoVim uses an init file to start up (in `~/.config/nvim/`), which can either
be `init.vim` or `init.lua` written in vimscript or luascript, respectively.
I used this to [synchronize the plugins between vim and
NeoVim](https://www.baeldung.com/linux/vim-neovim-configs), but had not migrated
to using `init.lua`.

In 2024, the [Nvim-R plugin](https://github.com/jalvesaq/Nvim-R/)
has been superseded by [R.nvim](https://github.com/R-nvim/R.nvim), and all the
configuration instructions use lua script. I had attempted to switch over in
early 2024, but I could not find the right tutorials for migrating over and
ended up borking my nvim setup (but because I had this repo, I could easily
go back).

In July 2024, I found [a good walkthrough to convert vimrc to
lua](https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/),
which includes the inital steps of calling vimscript from lua and then the
incremental process of conversion. What the author ended up with was a set of
configurations for NeoVim controlled by `~/.config/nvim/init.lua` and auxillary
files and then a set of configurations for vim controlled by `~/.vimrc`.

With this in mind, I have set up my vim to be very similar and have copied over
the nvim configuration into [the `nvim/` folder](nvim) and have symlinked that
directory to `~/.config/nvim/`.

## .gitconfig

To use the .gitconfig in your own .gitconfig, use the `[include]` directive:

```toml
[user]
    name = "Your Name"
    email = "your.name@example.com"
    signingkey = "<your GPG or SSH signing key ID>"
[include]
    path = "/path/to/config-files/.gitconfig"
[commit]
    gpgSign = true
[tag]
    gpgSign = true
```

## kitty

The kitty config is symlinked to `~/.config/kitty/kitty.conf`

### Changing colors

I previously had some keyboard mappings to change colors in kitty, but it got
more complicated with [the themes kitten](https://sw.kovidgoyal.net/kitty/kittens/themes/)
where it would modify the `kitty/kitty.conf` file to include the following lines:

```sh
# BEGIN_KITTY_THEME
# <theme name>
include current-theme.conf
# END_KITTY_THEME
```

Every time I changed the theme, my kitty conf would be changed in git's eyes.
[The way I rectified this was to use git
filters](https://stackoverflow.com/a/5272721/2752888) which would act on the
`kitty/kitty.conf` file by removing those lines alltogether:

> BIG CAVEAT: This must be done on each computer separately. The git
> configuration is not replicated across computers.

In `.git/config`

```toml
[filter "badkitty"]
  clean=sed '/BEGIN_KITTY_THEME/,/END_KITTY_THEME/ d'
  smudge=sed '/BEGIN_KITTY_THEME/,/END_KITTY_THEME/ d'
```

In `.git/info/attributes`

```toml
kitty/kitty.conf filter=badkitty
```
