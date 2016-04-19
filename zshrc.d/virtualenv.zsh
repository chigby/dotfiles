if [ -f /opt/local/bin/python ]; then
    export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python
elif [ -f /usr/bin/python ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
fi

if [ -f /opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    . /opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/virtualenvwrapper.sh
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    . /usr/local/bin/virtualenvwrapper.sh
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1
