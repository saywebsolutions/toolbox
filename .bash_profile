if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -d "$HOME/adb-fastboot" ] ; then
 export PATH="$HOME/adb-fastboot:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
