# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# set history size to be unlimited
HISTSIZE=
HISTFILESIZE=

export PATH=$PATH:$HOME/bin

# gcc4.8
export PATH=/opt/compiler/gcc-4.8.2/bin/:$PATH

# bcloud
export PATH=/home/work/.BCloud/bin:$PATH
alias b='bcloud'
alias bl='bcloud local'
alias bb='bcloud build'

# jumbo
[[ -s "/home/work/.jumbo/etc/bashrc" ]] && source "/home/work/.jumbo/etc/bashrc"

# git
[[ -s "/home/work/bin/git-completion.bash" ]] && source "/home/work/bin/git-completion.bash"
[[ -s "/home/work/bin/git-prompt.sh" ]] && source "/home/work/bin/git-prompt.sh"
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

