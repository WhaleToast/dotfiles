eval "$(ssh-agent -s)"   
ssh-add ~/.ssh/github
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"
export SYSTEMD_EDITOR=/usr/bin/nvim
ZSH_THEME="darkblood"

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

webdock(){
	ssh -i /home/sollkre/.ssh/webdock sollkre@193.181.209.189
}
webdockepyc(){
	ssh -i /home/sollkre/.ssh/webdock sollkre@193.180.215.130 
}

alias vim=nvim

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias wifi-scan='bash /home/sollkre/bin/wifi-scan.sh'
alias rotate-recordings='bash /home/sollkre/bin/rotate-recordings.sh'
export PATH=$PATH:/home/sollkre/.local/bin
