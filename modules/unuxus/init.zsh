source /etc/unuxus/env

# Use zsh-completions from Homebrew if installed
[ -d /usr/local/share/zsh-completions ]  && fpath=(/usr/local/share/zsh-completions $fpath)
