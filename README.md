# Homer

Homer is a home directory manager for your shell. Using [Git][git], it
tracks changes in your home directory configuration from anywhere on
your machine. Its goal is to uncover the IDE-like possibilities of the
shell and make such features more approachable to newer users, while
still retaining its usefulness to power users.

Homer is an opinionated, but minimal, framework. While most of what
it assumes about your environment is strongly enforced across the
framework, it attempts to assume very little about your system, instead
allowing you to customize your shell the way you see fit. In many ways,
Homer is really meant to just get rid of all the boilerplate code one
would need to have a really stellar shell environment.

## How It Works

Homer is effectively a Git repo and shell manager that can be accessed
from anywhere on the machine. It's written entirely in ZSH shell script
in a way that's both performant and highly accurate. Homer is really
nothing more than a set of conventions, a few shell scripts to make
things easier, and some useful/sane defaults for ZSH. All of Homer's
components are simply tools that wrap a Git repository, usually
performing a command in the process (like adding an alias or copying a
whole script) which involves changing a file in the home directory.

Homer is very similar to tools like [GNU Stow][stow], its main
difference is that instead of keeping a directory separate from
`$HOME` and symlinking the necessary files over from some
version-controlled directory when asked, Homer simply uses the home
directory as a Git repo. This provides a number of benefits including
the ability to keep entire directories of content tracked, omission of
secret/large/irrelevant files with a whitelisted `~/.gitignore`, and 

## Features

- Sync home directory configuration with GitHub
- Keep music and media files in their respective folders (`~/Music`,
  `~/Movies`, etc.)
- Stores documents in ~/Documents.

## Installation

There are a number of ways to install Homer...

### From a Package Manager

Currently, Homer is only available on Homebrew:

```bash
$ brew tap tubbo/brewery
$ brew install homer
```

### From Source

Before installing from source, make sure you have the following hard
dependencies installed:

- zsh
- chruby
- ruby-install
- python
- pip
- powerline

Once they're all installed, run the following commands to install to
`/usr/local`...

```bash
$ git clone https://github.com/tubbo/homer.git
$ cd homer
$ make install
```

When its installed, run the setup command:

```bash
$ homer init
```

## Usage

Homer can save your dotfiles.

```bash
$ homer save .vimrc -m "Removed vim-rails"
```

Homer can sync with your Git repo.

```bash
$ homer update
```

(To update Homer itself, use Homebrew: `brew upgrade homer`)

Homer can install shell plugins.

```bash
$ homer plugin install zsh-users/zsh-syntax-highlighting
```

As well as remove them.

```bash
$ homer plugin uninstall zsh-users/zsh-syntax-highlighting
```

Homer can add aliases and save them for later use.

```bash
$ homer alias gc 'git commit'
$ gc -m "wow this is cool"
```

It can also delete them.

```bash
$ homer alias -d gc
```

Homer can copy useful scripts to your `$PATH`.

```bash
$ homer script bin/find-and-replace-in-project
$ find-and-replace-in-project
```

Homer isn't the smartest guy in the world, but he gets the job done.

### Conventions

Homer establishes a number of conventions on your home directory. It
uses the **bin/** directory to store user-made scripts which can be made
available in the path. It creates an **etc/** directory and uses that to
store files such as **etc/plugins.zsh** for defining shell plugins and
**etc/aliases.zsh** for storing shell aliases you wish to recall later.
Note that the aforementioned files should not be edited manually, the
`homer alias` and `homer plugin` tools are meant to manage the files for
you.

## Development

Homer is written entirely in ZSH shell script. It uses [BATS][bats] to
run its tests. All contributions must include tests.

[bats]: https://github.com/sstephenson/bats
