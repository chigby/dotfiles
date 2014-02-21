#!/usr/bin/env python

# example use:
#
# cd ~/git/spokenrune/content/readings
# grep duration *.markdown|awk '{print $2}'|sed -e 's/"//g'|~/temp/durations.py
#
# grep -E "^created|duration" * |~/temp/durations.py

import sys
from collections import Counter
from datetime import timedelta, datetime
from dateutil import parser
from itertools import tee
from operator import add

def to_delta(s):
    minutes, seconds = map(int, s.split(':'))
    return timedelta(minutes=minutes, seconds=seconds)


def median(lst):
    num = len(lst)
    lst = sorted(lst)
    if num % 2 != 0:
        return (lst[num // 2] + lst[num // 2 - 1]) / 2
    else:
        return lst[num // 2]


def mode(lst):
    return Counter(lst).most_common(1)[0][0]


def clean(text):
    return text.split(' ')[-1].strip('\n"')


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def main():
    durations = []
    creations = []
    for line in sys.stdin:
        if 'duration' in line:
            durations.append(to_delta(clean(line)))
        elif 'created' in line:
            print('Processing', clean(line), '--->', parser.parse(clean(line), ignoretz=True))
            creations.append(parser.parse(clean(line), ignoretz=True))

    print('Mean', sum(durations, timedelta()) / len(durations))
    print('Median', median(durations))
    print('Max', max(durations))
    print('Min', min(durations))
    print('Mode', mode(durations))

    print('------')
    print('Earliest', min(creations))
    print('Latest', max(creations))
    print('Span', max(creations) - min(creations))
    print('Rate (days/reading)', (max(creations) - min(creations)).days / len(creations) )

    print('Largest gap', *map(str, max(pairwise(sorted(creations)), key=lambda k: k[1] - k[0])))
    print('Smallest gap', *map(str, min(pairwise(sorted(creations)), key=lambda k: k[1] - k[0])))
    gaps = list(map(lambda p: p[1] - p[0], pairwise(sorted(creations))))
    print('Median gap', median(gaps))
    print('Mean gap', sum(gaps, timedelta()) / len(gaps))
    print('Mode gap', mode(gaps))
    return 0

if __name__ == '__main__':
    sys.exit(main())