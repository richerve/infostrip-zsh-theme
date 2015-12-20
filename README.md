# Infostrip zsh theme

A functional zsh theme with no fancy pretensions. Fully customizable

## What it can shows

* Ruby version using chruby.
    - Always or when it detects an .rb or .ruby_version file
* Python virtualenv.
* Git info.
* Current directory, full or short.
* Time
* Exit code of last command.
* zsh vim mode.
* user and hostname

![Infostrip example](https://raw.githubusercontent.com/richerve/infostrip-zsh-theme/master/infostrip-example.png)
## Installing

The infostrip theme uses some functions and variables from base oh-my-zsh, mostly for the git info.

To installing it add the corresponding lines in your **~/.zshrc** corresponding to the zsh package manager that you have.

### For Zplug users (Recommended)

If you're using [zplug](https://github.com/b4b4r07/zplug). You need to load at least one plugin from oh-my-zsh or the main script in oh-my-zsh repo if you want.

#### Load one oh-my-zsh plugin first
```bash
zplug "plugins/git", from:oh-my-zsh
zplug "richerve/infostrip-zsh-theme"
```

#### Load main oh-my-zsh script
```bash
zplug "robbyrussell/oh-my-zsh", of:oh-my-zsh.sh, nice:-10
zplug "richerve/infostrip-zsh-theme"
```

### For Zgen users

If you're using [zgen](https://github.com/tarjoilija/zgen).

```bash
zgen oh-my-zsh
zgen load richerve/infostrip-zsh-theme
```

## Variables and default values

All variables can be defined in .zshrc (after loading the theme) to rewrite the default value.

### PROMPT
```
INFOSTRIP_PROMPT_CHAR=${:-"\u276f "} #❯
INFOSTRIP_PROMPT_ORDER=${:-"hostname dir git ruby venv"}
```

The value of *INFOSTRIP_PROMPT_ORDER* is a "string" with words separated by one space, the possible values are:

```
hostname
dir
time
git
ruby
venv
```

### CONTEXT
```
INFOSTRIP_PROMPT_USER_BG=${:-"default"}
INFOSTRIP_PROMPT_USER_FG=${:-cyan}
INFOSTRIP_PROMPT_HOST_BG=${:-default}
INFOSTRIP_PROMPT_HOST_FG=${:-"cyan"}
```

### DIR
```
INFOSTRIP_DIR_BG=${:-default}
INFOSTRIP_DIR_FG=${:-blue}
INFOSTRIP_DIR_LEN=${:-0}
```

### TIME
```
INFOSTRIP_TIME_BG=${:-white}
INFOSTRIP_TIME_FG=${:-black}
```

### VIRTUALENV
```
INFOSTRIP_VIRTUALENV_BG=${:-default}
INFOSTRIP_VIRTUALENV_FG=${:-green}
INFOSTRIP_VIRTUALENV_PREFIX=${:-"\ue73c"} # or \ue606
```

### RUBY
```
INFOSTRIP_RUBY_BG=${:-default}
INFOSTRIP_RUBY_FG=${:-red}
INFOSTRIP_RUBY_PREFIX=${:-"\ue739"} # or \ue605
INFOSTRIP_RUBY_ALWAYS=${:-false}
```

### GIT
```
INFOSTRIP_GIT_BG=${:-default}
INFOSTRIP_GIT_FG=${:-white}
ZSH_THEME_GIT_PROMPT_PREFIX=${:-"\ue0a0 "} # or \ue702
ZSH_THEME_GIT_PROMPT_SUFFIX=${:-""}
ZSH_THEME_GIT_PROMPT_DIRTY=${:-"%F{red} ✘ %f"}
ZSH_THEME_GIT_PROMPT_CLEAN=${:-"%F{green} ✔ %f"}
ZSH_THEME_GIT_PROMPT_ADDED=${:-"%F{cyan}✚ %f"}
ZSH_THEME_GIT_PROMPT_MODIFIED=${:-"%F{blue}✹ %f"}
ZSH_THEME_GIT_PROMPT_DELETED=${:-"%F{red}✖ %f"}
ZSH_THEME_GIT_PROMPT_UNTRACKED=${:-"%F{yellow}✭ %f"}
ZSH_THEME_GIT_PROMPT_RENAMED=${:-"➜ "}
ZSH_THEME_GIT_PROMPT_UNMERGED=${:-"═ "}
ZSH_THEME_GIT_PROMPT_AHEAD=${:-"⬆ "}
ZSH_THEME_GIT_PROMPT_BEHIND=${:-"⬇ "}
ZSH_THEME_GIT_PROMPT_DIVERGED=${:-"⬍ "}
```

## Fonts

To use the default icons for ruby and virtualenv, you need to have a patched font that has the icons added.

One way is to use any patched font from: [nerd-fonts](https://github.com/ryanoasis/nerd-fonts). You can use the "minimal" version of any font present in that repo.

## License
The MIT License (MIT)

Copyright (c) 2015 Ricardo Hernández (richerVE)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
