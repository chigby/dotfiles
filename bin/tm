#!/usr/bin/env python

# TODO: --loop option: continuously runs, rings bell every N minutes

from datetime import datetime, timedelta
from os import path
import subprocess
import time
import sys

MIN = timedelta(seconds=1)
MAX = timedelta(days=1)

def play_sound():
    home = path.expanduser('~')
    sound_path = path.join(home, 'sounds/hugebell.mp3')
    subprocess.call(['afplay', sound_path])

def timer(length):
    end = datetime.utcnow() + length
    while datetime.utcnow() < end - timedelta(seconds=1):
        timestr = str(timedelta(seconds=(end - datetime.utcnow()).seconds))
        sys.stdout.write(timestr)
        sys.stdout.flush()
        time.sleep(1)
        sys.stdout.write('\b'*len(timestr))

    play_sound()


def main(argv):
    if len(argv) != 2:
        print('Usage: timer.py [MINUTES]')
        sys.exit(1)
    try:
        length = timedelta(minutes=float(argv[1]))
    except (TypeError, ValueError):
        print('"{0}" not numeric.'.format(argv[1]))
        sys.exit(1)
    except OverflowError:
        length = timedelta.max
    if not MIN < length < MAX:
        print('Timer out of bounds.  Must be between one second and one day, i.e. {:.2} < t < {}'.format(MIN.total_seconds()/60, int(MAX.total_seconds()//60)))
        sys.exit(1)
    timer(length)


if __name__ == '__main__':
    try:
        main(sys.argv)
    except KeyboardInterrupt:
        sys.exit()
