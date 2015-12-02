if [[ -e /usr/share/scala ]]; then
    export SCALA_HOME=$(/usr/share/scala)
    path=("$SCALA_HOME" $path)
fi
