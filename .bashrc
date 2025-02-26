# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias update="sudo dnf upgrade && sudo flatpak update && sudo snap refresh"
alias kubectl="microk8s kubectl"
alias helm="microk8s helm"
alias setup-ssh='eval "$(ssh-agent -s)" | ssh-add ~/.ssh/github | ssh-add ~/.ssh/bitbucket'

# alias logseq="./Logseq-linux-x64-0.10.9.AppImage --no-sandbox"

eval "$(starship init bash)"

fastfetch

export GOPATH=$HOME/go
