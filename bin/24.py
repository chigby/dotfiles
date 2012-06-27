from functional import foldl1, foldr1
from operator import add, sub, mul, div, mod
from itertools import product, permutations

ops = [add, sub, mul, div]
nums = [1, 3, 4, 6]
nums = map(float, nums)
target = 24
threshhold = 1
found = False

for n in permutations(nums):
    for p in product(ops, repeat=3):
        operators = (i for i in p)
        try:
            left_result = foldl1(lambda q, v: operators.next()(q, v), n)
        except ZeroDivisionError:
            continue
        operators = (i for i in p)
        try:
            right_result = foldr1(lambda q, v: operators.next()(q, v), n)
        except ZeroDivisionError:
            continue
        if target == right_result:
            print 'right'
            ops = (i for i in p)
            def show_work(q, v):
                print '----------------------------------------'
                print 'showing work:'
                print q, v
                f = ops.next()
                print f
                return f(q, v)
            foldr1(show_work, n)
            found = True
            print p, n
        if target == left_result:
            print 'left'
            found = True
            print p, n



if found:
    print "woo"
else:
    print "sad"
