if which dotnet >/dev/null 2>&1 ; then
	if [ -d "/snap/dotnet-sdk/current" ] ; then
	  export DOTNET_ROOT=/snap/dotnet-sdk/current
	fi
fi

