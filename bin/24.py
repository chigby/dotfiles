import sys
import copy
from optparse import OptionParser
from itertools import product, permutations, izip_longest, chain
from expr_parser import parse

def main(args):
    parser = OptionParser()
    parser.add_option('-s', '--show', dest='show', action='store_true',
                      help='show solutions')
    (options, args) = parser.parse_args(args[1:])
    find_solution(args, options.show)


def flatten(listOfLists):
    "Flatten one level of nesting"
    return chain.from_iterable(listOfLists)

def paren_combations(iterable, r=2):
    # combinations('ABCD', 2) --> AB AC AD BC BD CD
    # combinations(range(4), 3) --> 012 013 023 123
    pool = tuple(iterable)
    parenthesized = list(copy.copy(iterable))
    n = len(pool)
    if r > n:
        return
    indices = range(r)

    parenthesized[indices[0]] = '(' + parenthesized[indices[0]]
    parenthesized[indices[1]] = parenthesized[indices[1]] + ')'
    yield parenthesized
    parenthesized = list(copy.copy(iterable))

    while True:
        for i in reversed(range(r)):
            if indices[i] != i + n - r:
                break
        else:
            return
        indices[i] += 1
        for j in range(i+1, r):
            indices[j] = indices[j-1] + 1

        parenthesized[indices[0]] = '(' + parenthesized[indices[0]]
        parenthesized[indices[1]] = parenthesized[indices[1]] + ')'
        yield parenthesized
        parenthesized = list(copy.copy(iterable))


def find_solution(nums, show=True, ops=list('+-*/')):
    solving_combinations = {}
    found = False
    for n in permutations(nums):
        for p in product(ops, repeat=3):
            if solving_combinations.get(n) == p:
                continue
            for c in paren_combations(n):
                expr = ''.join(str(i) for i in list(flatten(izip_longest(c, p, fillvalue=''))))
                try:
                    result = parse(expr)
                except ZeroDivisionError:
                    continue

                if result == 24:
                    found = True
                    if show:
                        print expr, '---->', result
                        solving_combinations[n] = p
                        break
                    else:
                        print 'solution exists'
                        return
    if not found:
        print 'no solution found'

if __name__ == '__main__':
    main(sys.argv)
