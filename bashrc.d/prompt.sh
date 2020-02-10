if which starship >/dev/null 2>&1 ; then
  eval "$(starship init bash)";
else
  # don't put duplicate lines or lines starting with space in the history.
  # See bash(1) for more options
  HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  HISTSIZE=1000
  HISTFILESIZE=2000

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  #shopt -s globstar

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color|*-256color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
      else
    color_prompt=
      fi
  fi

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
    echo -n $(git branch --no-color 2>/dev/null | awk -v out=$1 '/^*/ { if(out=="") print $2; else print out}')
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
