# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="geoffgarside"

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

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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

