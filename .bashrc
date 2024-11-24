#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# starfish config
eval "$(starship init bash)"

# Distrobox
# alias ros="distrobox enter larcc-distrobox"
# alias gym="distrobox enter gym-distrobox"
# alias code_ros="/home/miglou/.local/bin/vscode-distrobox larcc-distrobox /home/miglou/larcc-distrobox/catkin_ws/src"
# alias code_gym="/home/miglou/.local/bin/vscode-distrobox gym-distrobox /home/miglou/gym-distrobox/catkin_ws/src"
alias ubuntu="distrobox enter ubuntu24"
alias code_ubuntu="/home/miglou/.local/bin/vscode-distrobox ubuntu24 /home/miglou/ubuntu24-distrobox"

# fastfetch
fastfetch

# pokemon
# pokemonshow
