# Stripped dotfiles

Specialized for PHP, Git and Linux.

## Installation

```bash
bash -c "`curl -sS dot.reenlokum.nl`"
```

It’ll clone the latest version of dotfiles to `~/dotfiles` and makes symlinks in your home directory.

## Updating

```bash
dotfiles
```

## Features

* Custom Bash prompt.
* Git config, Git global ignore file.
* Dotfiles syncronization (`sync`).
* Composer (+updates)

## TODO

* Automatic `.gitlocal` generation.
* Key discovery & download.
* Symfony 2 autocompletion

## Notes

You can use any file extensions in `tilde/` to invoke proper syntax highlighting in code editor.

## Further customization

* Add any Bash profile customizations to `~/.bashlocal`.
* Add your git username/email/etc. to `~/.gitlocal`.
* Just fork this repo and hack on.

## Out of memory issue

To resolve the error "Cannot allocate memory", run the following command:

```
sudo sed -i 's/memory_limit = 128M/memory_limit = 1G/g' /etc/php.ini
```

## Resources

* [jacobkiers/dotfiles](https://bitbucket.org/jacobkiers/dotfiles)
* [GitHub ❤ ~/](http://dotfiles.github.com/)
* [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Jan Moesen’s dotfiles](https://github.com/janmoesen/tilde)
* [Nicolas Gallagher’s dotfiles](https://github.com/necolas/dotfiles)
* [Zach Holman’s dotfiles](https://github.com/holman/dotfiles)
* [Jacob Gillespie’s dotfiles](https://github.com/jacobwg/dotfiles)
* [Yet Another Dotfile Repo](https://github.com/skwp/dotfiles)
* [Yet another cool story about bash prompt](http://habrahabr.ru/company/mailru/blog/145008/) (in Russian)
