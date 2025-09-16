eval "$(ssh-agent -s)"   
ssh-add ~/.ssh/github
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"
export SYSTEMD_EDITOR=/usr/bin/nvim
export PATH=$PATH:/home/sollkre/.local/bin


ZSH_THEME="darkblood"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias cls="clear"
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias hmmm='yay -Sy &> /dev/null && yay -Qu'
alias uwe='curl wttr.in/Oslo | head -n -1'
alias pkglist='pacman -Qi | grep -E "Name|Description" | less'
alias sudo="sudo "
alias clearcache="yay -Sc && sudo pacman -Scc"
alias neofetch="fastfetch -c neofetch.jsonc"
alias vim=nvim
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias wifi-scan='bash /home/sollkre/bin/wifi-scan.sh'
alias rotate-recordings='bash /home/sollkre/bin/rotate-recordings.sh'

# Function to remove orphaned packages
yeet() {
    local orphans logfile
    logfile="$HOME/logs/.yeet_log"
    orphans=$(pacman -Qtdq)
    
    if [[ -z "$orphans" ]]; then
        echo "There are no orphaned packages."
    else
        echo "The following orphaned packages will be removed:"
        echo "$orphans"
        echo
        read "confirm?Do you want to remove all orphaned packages? (y/N): "
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            # Log the removal with timestamp
            echo "=== $(date) ===" >> "$logfile"
            echo "$orphans" >> "$logfile"
            echo "" >> "$logfile"
            
            echo "$orphans" | sudo pacman -Rs --noconfirm -
            echo "Orphaned packages removed and logged to $logfile"
        else
            echo "No packages were removed."
        fi
    fi
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
