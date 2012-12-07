import os

def get_password(account):
    cmd = "/usr/bin/security 2>&1 >/dev/null find-generic-password -a {0} -g".format(account)
    line = os.popen(cmd).readline()
    passwds = line.split()
    if len(passwds) == 3 or len(passwds) == 2:
        return passwds[-1][1:-1].decode('string_escape')
    else:
        return ''
