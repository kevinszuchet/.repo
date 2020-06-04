if which aws >/dev/null 2>&1 ; then
	if [ -d "$HOME/.local/bin/aws" ] ; then
	  PATH="$PATH:$HOME/.local/bin/aws"
	fi
fi