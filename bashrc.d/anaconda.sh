if which conda >/dev/null 2>&1 ; then
	# !! Contents within this block are managed by 'conda init' !!
	__conda_setup="$('/home/kevin/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "/home/kevin/anaconda3/etc/profile.d/conda.sh" ]; then
			. "/home/kevin/anaconda3/etc/profile.d/conda.sh"
		else
			export PATH="/home/kevin/anaconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
fi