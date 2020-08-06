if which rvm >/dev/null 2>&1 ; then
	if [ -d "$HOME/.rvm/bin" ] ; then
	  PATH="$PATH:$HOME/.rvm/bin"
	  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
	fi
fi