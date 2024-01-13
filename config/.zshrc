export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="geoffgarside"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#alias
# alias mksl="sudo rm -f config.h && sudo make clean install && make clean"
# alias 60fps="xrandr --output eDP-1 --mode 2560x1600 --rate 60"
# alias pcmset="wpctl set-default"
# alias pcm="wpctl status | head -n 30"
# alias chkey="xmodmap ~/.Xmodmap"
# alias show-bat="cat /sys/class/power_supply/BAT0/capacity"
alias n="nvim"
alias ra="ranger"
alias condaE="source ~/Code/dotfile/scripts/condaEnable"
alias cax="conda activate xwx"
alias cls="clear"
alias pc="proxychains"
alias wp="feh --bg-fill --no-fehbg --randomize ~/Media/wallpaper/"
alias bgm="m --pause --script-opts=osc-visibility=never --playlist=/home/xwx/Media/Bangumi/playlist"
alias modi="sudo envycontrol -s integrated"
alias modn="sudo envycontrol -s nvidia --force-comp --coolbits --dm sddm"
alias modh="sudo envycontrol -s hybrid --dm sddm"
alias modq="sudo envycontrol -q"
alias mp="m --playlist=playlist"
alias pm="python3.7 -m"
alias ss="sudo systemctl"
alias clashR="sudo systemctl daemon-reload && sudo systemctl restart clash"
alias cax="source ~/.pyxwx/bin/activate"
alias nvdri="lspci -nnk | awk '/01:00\.0/,/driver/{if (NR==start+2) print \$5} {if (\$0 ~ /01:00\.0/) start=NR}'"
alias ract="source ~/.cleanrl/bin/activate && cd ~/Code/cleanrl && poetry shell"
alias 144="xrdb -merge <<< Xft.dpi:144"
alias 128="xrdb -merge <<< Xft.dpi:128"
alias nf="neofetch"
alias lab="ssh xmh0@lab"

# Env
export EDITOR="nvim"
export PATH=$PATH:/home/xwx/.local/bin:/home/xwx/.py39/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/xwx/.anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/xwx/.anaconda/etc/profile.d/conda.sh" ]; then
#         . "/home/xwx/.anaconda/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/xwx/.anaconda/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

