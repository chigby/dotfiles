import sys
import getopt
from itertools import *
from subprocess import Popen


class ISpell:
    def __init__(self):
        self._f = Popen("ispell")
        self._f.fromchild.readline() #skip the credit line
    def __call__(self, word):
        self._f.tochild.write(word+'\n')
        self._f.tochild.flush()
        s = self._f.fromchild.readline()
        self._f.fromchild.readline() #skip the blank line
        if s[:8]=="word: ok":
            return None
        else:
            return (s[17:-1]).split(', ')

def powerset(iterable):
    "powerset([1,2,3]) --> () (1,) (2,) (3,) (1,2) (1,3) (2,3) (1,2,3)"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return izip(a, b)

def encode(text, substitutions):
    output = [' '] * len(text)
    for i in range(0, len(text)):
        if substitutions.has_key(text[i]):
            output[i] = substitutions[text[i]]
        else:
            output[i] = text[i]
    return ''.join(output)

def find_permutations(text, elements):
    results = []
    for elem in permutations(elements):
        if elem[0][0] != text[0]:
            continue
        for i in range(len(elem) + 1):
            if ''.join(elem[:i]) == text:
                results.append(elem[:i])
                break
    return [decode(elem, substitutions) for elem in list(set(results))]

def decipher(text, substitutions):
    results = []
    digrams = [''.join(elem) for elem in pairwise(text)]
    monograms = list(text)
    monograms.extend(digrams)
    monograms = [elem for elem in monograms if elem in [str(i) for i in range(1, 26)]]
    digrams = [elem for elem in monograms if len(elem) > 1]
    for subset in powerset(digrams):
        characters = []
        replace_text = list(text)
        i = 0
        while i < len(replace_text):
            if ''.join(replace_text[i:i+2]) not in subset:
                characters.append(replace_text[i])
                i = i + 1
            else:
                for elem in subset:
                    if ''.join(replace_text[i:i+2]) == elem:
                        characters.append(elem)
                        i = i + 2
        if "0" not in characters:
            results.append(characters)
    return list(set([decode(result, substitutions) for result in results]))

def decode(text, substitutions):
    # create 'reverse' substitutions.
    reverse_subs = {};
    for key in substitutions:
        reverse_subs[substitutions[key]] = key
    return encode(text, reverse_subs)


args = sys.argv[1:] #.split()
optlist, args = getopt.getopt(args, 'd', ['decode'])
decrypt = False

for o, a in optlist:
    if o == '--decode':
        decrypt = True

alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
substitutions = {}
text = args[0]
for i in range(1, 26):
    substitutions[alphabet[i-1]] = str(i)
if decrypt:
    for word in text.split(' '):
        ispell = ISpell()
        print "%s --> %s" % (word, [w for w in decipher(word, substitutions) if ispell(w) is None])
else:
    print "%s --> %s" % (text, encode(text.upper(), substitutions))
        
