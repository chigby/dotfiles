#!/usr/bin/env python

from datetime import datetime, timedelta
import time
import os
import sys

def play_sound():
    home = os.path.expanduser('~')
    sound_path = os.path.join(home, 'sounds/hugebell.mp3')
    os.system('afplay {sound_path}'.format(sound_path=sound_path))

def timer(seconds):
    start = datetime.utcnow()
    end = start + timedelta(seconds=seconds)
    now = start

    while True:
        now = datetime.utcnow()
        if now < end:
            timestr = str(timedelta(seconds=(end - now).seconds))
            sys.stdout.write(timestr)
            sys.stdout.flush()
            time.sleep(1)
            sys.stdout.write('\b'*len(timestr))
        else:
            break

    play_sound()


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
