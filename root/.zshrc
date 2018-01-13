# Disable Messaging
mesg n

# Not an interactive shell? Time to leave...
[ -z "$PS1" ] && return

# Options
setopt autocd
setopt extendedglob
setopt no_bg_nice
setopt nomatch
setopt ksh_autoload
setopt noflowcontrol

# Custom functions & other auto-loads
autoload -U compinit && compinit -u 2>/dev/null
autoload -U colors && colors 2> /dev/null

# Input controls
bindkey -e
alias ':q=exit'

# Make sure emacs can never return
export EDITOR="vim"

# Auto Logout
export TMOUT=300
readonly TMOUT

# History configuration
setopt appendhistory
setopt sharehistory
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000

# Beep command
# Hang over from my time with dos
# Used a lot to notify after long tasks...
alias beep="echo -en '\007'"

# Enable color where supported
dircol=`which dircolors`;
if [ -x "$dircol" ]; then
	eval `dircolors -b`
	alias 'ls=ls --color=auto'
fi
alias 'grep=grep --colour=auto'

export COLORFGBG='default;default'

# Short command aliases
ll()
{
	command ls -h -l --color=always $* | more
}
alias 'lk=ll -A'
alias 'l=ll'
alias 'tf=tail -f'

#---COMPLETION STUFF------------------------------------------------------
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::*:(rm|vim):*' ignore-line true
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o' '*.pdf'
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.aux' '*.dvi' '*.out' '*.nav' '*.snm'

compctl -g '*.tar.bz2 *.tar.gz *.bz2 *.gz *.jar *.rar *.tar *.tbz2 *.tgz *.zip *.Z' + -g '*(-/)' extract

#---PROMPT STUFF----------------------------------------------------------

# User name colour and prompt char different for root
if [ $UID -eq 0 ]; then
	c_prompt='#'
	u_color=${fg_bold[red]}
else
	c_prompt='$'
	u_color=${fg_bold[yellow]}
fi

# <user>@<host>:<cwd>$ or root@<host>:<cwd>#
export PS1="%{$u_color%}%n@%M%{$fg[white]%}:%{$fg_bold[blue]%}%5c%{$reset_color%}${c_prompt} "
