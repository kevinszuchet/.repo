if which android-studio >/dev/null 2>&1 ; then
	if [ -d "$HOME/Android/Sdk" ] ; then
      ANDROID_HOME="$HOME/Android/Sdk"
	  PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
	fi
fi