export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python
if [ -f /opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    . /opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/virtualenvwrapper.sh
fi
