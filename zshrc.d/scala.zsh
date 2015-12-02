if [[ -d /usr/share/scala ]]; then
    export SCALA_HOME=$(/usr/share/scala)
    path=("$SCALA_HOME/bin" $path)
fi
