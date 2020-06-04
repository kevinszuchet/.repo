if which starship >/dev/null 2>&1 ; then
  eval "$(starship init bash)";
else
  # declares both arrays with the emojis we want to support
  OK_EMOJIS=(😎 😜 🤓 😍)
  FAIL_EMOJIS=(💩 🚽 🖕 💀 👻 🙊 🙈)

  # export CLICOLOR=1;
  # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx;

  # function that select the emojis array by the result of the previous command
  # and return a random element from the EMOJIS set
  RANDOM_EMOJI() {
    if [ $? -eq 0 ] ; then
      SELECTED_EMOJI=${OK_EMOJIS[$RANDOM % ${#OK_EMOJIS[@]}]};
    else
      SELECTED_EMOJI=${FAIL_EMOJIS[$RANDOM % ${#FAIL_EMOJIS[@]}]};
    fi

    echo $SELECTED_EMOJI;
  }

  parse_git_branch() {
    echo -n $(git branch --no-color 2>/dev/null | awk -v out=$1 '/^$/ { if(out=="") print $2; else print out}')
  }

  # \e: an ASCII escape character (033)
  PS1="${debian_chroot:+($debian_chroot)}\n\$(RANDOM_EMOJI)  "

  if [ "$color_prompt" = yes ]; then
      # PS1="${PS1}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] "
      PS1="${PS1}\[\e[m\]\[\e[1;32m\]\[\e[4;31m\]\u\[\e[m\] \[\e[0;36m\]in \[\e[0;37m\]\w\[\e[m\] \[\e[0;33m\]\$(parse_git_branch)\[\e[m\]\[\e[1;32m\]\n \[\e[m\] \[\e[0;37m\]"
  else
      # PS1="${PS1}\u@\h:\w\$(parse_git_branch) "
      PS1="${PS1}\u \w \$(parse_git_branch)\n "
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
  esac

  export PS1
fi
