eval "$(ssh-agent -s)"   
ssh-add ~/.ssh/github
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export VISUAL="gedit"
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"
export SYSTEMD_EDITOR=/usr/bin/nvim
#. /opt/asdf-vm/asdf.sh
#Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="darkblood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# 
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias cls="clear"
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
#alias autorem='orphans=$(pacman -Qdtq); [ -z "$orphans" ] && echo "There are no orphaned packages" || sudo pacman -Rsc $orphans'
alias hmmm='yay -Sy &> /dev/null && yay -Qu'
alias uwe='curl wttr.in/Oslo | head -n -1'
alias pkglist='pacman -Qi | grep -E "Name|Description" | less'
alias sudo="sudo "
alias clearcache="yay -Sc && sudo pacman -Scc"
alias neofetch="fastfetch -c neofetch.jsonc"

# Function to remove orphaned packages
yeet() {
    local orphans
    orphans=$(pacman -Qdtq)

    if [[ -z "$orphans" ]]; then
        echo "There are no orphaned packages."
    else
        echo "The following orphaned packages will be removed:"
        echo "$orphans"
	echo
        read "confirm?Do you want to remove all orphaned packages? (y/N): "  # Zsh syntax for read with prompt

        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            for package in ${(f)orphans}; do  # Properly split output in Zsh
                sudo pacman -Rsc --noconfirm "$package"
            done
            echo "Orphaned packages removed."
        else
            echo "No packages were removed."
        fi
    fi
}
webdock(){
	ssh -i /home/sollkre/.ssh/webdock sollkre@45.148.31.50
}
alias vim=nvim

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias wifi-scan='bash /home/sollkre/bin/wifi-scan.sh'

export PATH=$PATH:/home/sollkre/.local/bin
