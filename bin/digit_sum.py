#!/usr/bin/env python

def complete_digit_sum(num, verbose=False):
     while (num > 9):
         num = digit_sum(num)
         if verbose:
             print num
     return num

def digit_sum(num):
     total = 0
     for i in str(num):
         total = total + int(i)
     return total

if __name__ == "__main__":
    from optparse import OptionParser

    parser = OptionParser()
    parser.add_option('-v', '--verbose', dest='verbose', action='store_true',
                      help='show all summation steps')
    opts, args = parser.parse_args()
    if len(args) != 1:
        parser.error("Numerical argument needed.")
    num = int(args[0])
    # print opts
    answer = complete_digit_sum(num, verbose=opts.verbose)
    if not opts.verbose:
        print answer

