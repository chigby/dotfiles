import operator
import re

token_pat = re.compile("\s*(?:(\d+\.?\d*)|(\*\*|.))")

class symbol_base(object):

    id = None
    value = None
    first = second = third = None

    def nud(self):
        raise SyntaxError('Syntax Error (%r).' % self.id)

    def led(self, left):
        raise SyntaxError('Unknown Operator (%r).' % self.id)

    def __repr__(self):
        if self.id in ('(name)', '(literal)'):
            return '(%s %s)' % (self.id[1:-1], self.value)
        out = [self.id, self.first, self.second, self.third]
        out = map(str, filter(None, out))
        return "(" + " ".join(out) + ")"

    def __str__(self):
        return self.__repr__()


symbol_table = {}

def symbol(id, bp=0):
    try:
        s = symbol_table[id]
    except KeyError:
        class s(symbol_base):
            pass
        s.__name__ = 'symbol-' + id
        s.id = id
        s.lbp = bp
        symbol_table[id] = s
    else:
        s.lbp = max(bp, s.lbp)
    return s

symbol('(literal)')
symbol('(end)')

def infix(id, bp, oper):
    def led(self, left):
        self.first = left
        self.second = expression(bp)
        return oper(self.first, self.second)
    symbol(id, bp).led = led

infix('+', 10, operator.add)
infix('-', 10, operator.sub)
infix('*', 20, operator.mul)
infix('/', 20, operator.div)

def prefix(id, bp):
    def nud(self):
        self.first = expression(bp)
        self.second = None
        return self
    symbol(id).nud = nud

prefix('+', 100)
prefix('-', 100)

symbol('(literal)').nud = lambda self: float(self.value)

def infix_r(id, bp):
    def led(self, left):
        self.first = left
        self.second = expression(bp-1)
        return self
    symbol(id, bp).led = led

infix_r('**', 30)

def advance(id=None):
    global token
    if id and token.id != id:
        raise SyntaxError('Expected %r' % id)
    token = next()

def nud(self):
    expr = expression()
    advance(')')
    return expr
symbol('(').nud = nud
symbol(')')

def expression(rbp=0):
    global token
    t = token
    token = next()
    left = t.nud()
    while rbp < token.lbp:
        t = token
        token = next()
        left = t.led(left)
    return left



def tokenize(program):
    for number, operator in token_pat.findall(program):
        #print number, operator
        if number:
            symbol = symbol_table['(literal)']
            s = symbol()
            s.value = number
            yield s
        else:
            symbol = symbol_table.get(operator)
            if not symbol:
                raise SyntaxError('Unknown Operator (%s).' % operator)
            yield symbol()
    symbol = symbol_table['(end)']
    yield symbol()


def parse(program):
    global token, next
    next = tokenize(program).next
    token = next()
    return expression()


# print parse('1.0/0.5')
# print parse('1+2*3')
# print parse('(1+2)*3')
# print parse('1+(2+3)*3')
