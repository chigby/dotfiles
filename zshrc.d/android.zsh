for dir in "$HOME/Android/Sdk/tools" "$HOME/Android/Sdk/platform-tools"; do
  if [[ -d $dir ]]; then
      path=($dir $path)
  fi
done
if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME=~/Android/Sdk
fi
