#!/usr/bin/env python

from datetime import datetime, timedelta
import time
import os
import sys

def timer(seconds):
    start = datetime.utcnow()
    end = start + timedelta(seconds=seconds)
    now = start
    os.system('clear')
    while True:
        now = datetime.utcnow()
        if now < end:
            os.system('clear')
            print timedelta(seconds=(end - now).seconds)
            time.sleep(1)
        else:
            break

    os.system('afplay /Users/cameronh/sounds/hugebell.mp3')


def main(argv):
    if len(argv) != 2:
        print 'Usage: timer.py [MINUTES]'
        sys.exit(1)
    try:
        seconds = float(argv[1]) * 60
    except ValueError:
        print '"{0}" not numeric.'.format(argv[1])
        sys.exit(1)
    timer(seconds)


if __name__ == '__main__':
    try:
        main(sys.argv)
    except KeyboardInterrupt:
        sys.exit()
