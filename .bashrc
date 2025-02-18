#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

#USER=`id -un`
LOGNAME=$USER
MAIL="/var/spool/mail/$USER"

HOSTNAME=`/bin/hostname`
export HISTSIZE=100000
export HISTFILESIZE=2000000
shopt -s histappend

# Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then

    function sha256sum() { shasum -a 256 "$@" ; } && export -f sha256sum

    export CLICOLOR=1
    export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

    alias ll='ls -lah'
    # mac replacement for md5sum command
    alias md5='md5 -r'
    alias md5sum='md5 -r'

else

    SAL_USE_VCLPLUGIN=gtk

    alias w="w | sort"
    alias who="who | sort"
    alias last="last -a | less"
    alias ls='ls --color=auto'
    alias grpe="grep --color"
    alias grep="grep --color"
    alias vi="vim"
    alias ll="du -sh * | sort -rh | head -n 25"
    alias lynx="lynx -vikeys"
    alias untar="tar -xvzf"
    alias testmic="arecord -vvv -f dat /dev/null"
    alias myip="ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'"
    alias kde-info="plasmashell --version; kf5-config --version"

    #docker
    alias dup="docker-compose up -d"
    alias ds="docker ps"

    alias sc='sudo SYSTEMD_EDITOR=/bin/vim systemctl'

    #git

    # I don't care about Ghostscript, and I will continue to not care about it
    #   until the need arises (if ever) to fix the clobbering of the native 'gs' command
    alias gs="git status"
    alias gd="git diff"

    alias topmem="ps -e -orss=,args= |awk '{print \$1 \" \" \$2 }'| awk '{tot[\$2]+=\$1;count[\$2]++} END {for (i in tot) {print tot[i],i,count[i]}}' | sort -n | tail -n 15 | sort -nr | awk '{ hr=\$1/1024; printf(\"%13.2fM\", hr); print \"\t\" \$2 }'"

    #laravel
    alias sail='bash vendor/bin/sail'

fi

alias sk="ssh-keygen -t rsa -b 4096 -o -a 100"
alias l_boiler="wget https://github.com/rappasoft/laravel-5-boilerplate/archive/master.zip"
alias l_perms="sudo chmod -R ug+rwx storage bootstrap/cache"
alias vif='vim $(fzf)'
alias v='vim $(fzf)'
alias gcam='git commit -am'

PAGER=less
VISUAL=vim
FCEDIT=vim
EDITOR=vim

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
# root
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ '

PATH="/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/lib:/usr/X11R6/bin:/usr/X11R6/lib:/usr/java/bin:/usr/java/lib:~/.config/composer/vendor/bin:~/.composer/vendor/bin:/home/linuxbrew/.linuxbrew/bin:/snap/bin:/usr/local/go/bin:$HOME/.deno/bin"
MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/share/binutils-data/i686-pc-linux-gnu/2.17/man:/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4/man:/usr/qt/3/doc/man"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function homestead() {
    ( cd ~/repos/Homestead && vagrant $* )
}

export GOPATH=~/gocode
PATH=$PATH:$GOPATH/bin

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!.vapor/*"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

  function fin {
      PACKAGE_NAME=$(apt-cache search $1 | fzf | cut --delimiter=" " --fields=1)
      if [ "$PACKAGE_NAME" ]; then
          echo "Installing $PACKAGE_NAME"
          sudo apt install $PACKAGE_NAME
      fi
  }

alias gbD="git for-each-ref --format='%(refname:short)' refs/heads | fzf -m | xargs git branch -D"

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

stty -ixon

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

source /usr/local/etc/bash_completion.d/deno.bash
export PATH="$HOME/.local/bin:$PATH"
