# wsl2-ssh-pageant-oh-my-zsh-plugin

[oh-my-zsh plugin](https://github.com/robbyrussell/oh-my-zsh) to use your
Yubikey stored GPG keys from WSL.

This plugin implements the instructions of the
[wsl2-ssh-pageant repo](https://github.com/BlackReloaded/wsl2-ssh-pageant) as a
oh-my-zsh plugin.

To create your certificate and keys, the most comprehensive guide is probably
the [YubiKey Guide](https://github.com/drduh/YubiKey-Guide) from drduh. In this
guide you will find information on how to backup properly your private keys.
However, the WSL part is for WSL 1.

[This other guide](https://jardazivny.medium.com/the-ultimate-guide-to-yubikey-on-wsl2-part-1-dce2ff8d7e45)
on Medium is specific to Windows and contains a section on WSL2.

This plugins avoids adding code to your `~/.zshrc` file when you're using
`oh-my-zsh` on WSL.

## Install

Create a new directory in `$ZSH_CUSTOM/plugins` called `wsl2-ssh-pageant` and
clone this repo into that directory. Note: it must be named `wsl2-ssh-pageant`
or oh-my-zsh won't recognize that it is a valid plugin directory.

```
git clone --depth 1 https://github.com/antoinemartin/wsl2-ssh-pageant-oh-my-zsh-plugin $ZSH_CUSTOM/plugins/wsl2-ssh-pageant
```

## Usage

Add `wsl2-ssh-pageant` to the `plugins=()` list in your `~/.zshrc` file and
you're done.
