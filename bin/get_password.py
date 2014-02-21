#!/usr/bin/env python2.7

import os
import sys

def get_password(account):
    cmd = "/usr/bin/security 2>&1 >/dev/null find-generic-password -a {0} -g".format(account)
    line = os.popen(cmd).readline()
    passwds = line.split()
    if len(passwds) == 3 or len(passwds) == 2:
        return passwds[-1][1:-1].decode('string_escape')
    else:
        return ''

def main(argv):
    print(get_password(argv[1]))
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))