import re

result = 'result.md'

def _dbg(s):
    print s

class emu(object):
    def __init__(self):
        self.code = {}
        self.fun_alias = {}
        self.data_alias = {}

        # TODO stakc is simplified to 32bit push/pop only
        self.stack = [0,] * 6553600

        # TODO parse statics (ds)
        self.data_alias['seed'] = [7L]
        self.data_alias['buffer'] = [0,] * 5000
        for k in self.data_alias:
            setattr(self, k, self.data_alias[k])

        # pseudo addr
        self.mem_addr = {
            'stack':0x8000000,
            'seed': 0x4000000,
            'buffer':0x4001000,
            0x8000000:'stack',
            0x4000000:'seed',
            0x4001000:'buffer'
        }
        # simplified
        self.jump_addr = []

        # ---- Registers ----
        self.R = [0,] * 16

        self.SP = len(self.stack)

        self.N = 0 # negative
        self.Z = 0 # zero
        self.C = 0 # carry
        self.V = 0 # overflow

    def run(self):
        depth = 10
        ttt=set()
        for l in open("qsort-fix.asm", "r").readlines():
            if not l.startswith('.text'):
                continue
            #print l
            _ = re.findall('.text:([A-F\d]+)\s+([^\s][^;\n\r]+)', l)
            if len(_) != 1:
                continue
            _loc, _instr = _[0]
            if _instr.startswith('EXPORT'):
                _vis, _name = _instr.strip().split()
                self.fun_alias[_name] = int(_loc, 16)
            elif 'XREF' in l or _instr.startswith(';'):#ignore
                continue
            elif _instr.startswith('var') or _instr.startswith('arg') or _instr.startswith('envp'):
                # NOTE var add arg addresses are not directly parsed
                # var_xx dword ptr - xx
                # arg_xx dword ptr 8 + xx
                # ignoring argv, argc, envp
                continue
            else:
                try:
                    opcode, operand = re.findall('([^ ]+)\s+(.+)', _instr)[0]
                except:
                    opcode = _instr
                    oprand = []
                self.code[int(_loc, 16)] = (opcode, operand)
                ttt.add(opcode)

        endp = max(self.code.keys())

        self._exit = False
        self.fun_alias['exit'] = 0x50000000
        self.code[0x50000000] = ('exit', [])
        self.fun_alias['__aeabi_idivmod'] = 0x50000400
        self.code[0x50000400] = ('aeabi_idivmod', [])

        self.next_addr = 0x00008464# hard coded
        single_step = False
        set_title = False
        stat = {}
        iteration = 0
        while True:
            text_addr = self.next_addr
            self.next_addr = text_addr + 4
            if text_addr not in self.code:
                if text_addr <= endp:
                    continue
                else:
                    _dbg("no next addr")
                    break
            opcode, operand = self.code[text_addr]
            # begin DEBUG
            if text_addr > 0x000085EC and text_addr < 0x00008648:
                import os
                #os.system("TITLE swap")
                set_title = True
            elif set_title:
                import os
            if text_addr == 0x000084E0:
                iteration += 1
                _dbg("current iter %d" % iteration)
                #os.system('title ')
            if 'quick' in operand :
                single_step = True
                #print self.R, self.SP,self.buffer
            #print(hex(text_addr), '=>', opcode, operand)
            getattr(self, opcode.upper())(operand)

            # begin stat
            if opcode not in stat:
                stat[opcode] = 0
            else:
                stat[opcode] += 1
            #print self.R, self.SP, self.stack,self.buffer
            if single_step:
                pass#raw_input()
            #print self.SP, self.R
            #print opcode, oprand
            _idx = self.code.keys().index(text_addr)
        print self.R, self.SP, self.stack,self.buffer
        self.stat(stat)
    
    def stat(self, stat):
        total = sum(stat.values())
        with open(result, 'w') as f:
            f.write(' instruction | count | percent\n------|------|------\n')
            for p in sorted(stat.keys(), key = lambda x:stat[x], reverse = True):
                print('%s\t%s\t%.2f%%\n' % (p, stat[p], 1.0 * stat[p] / total * 100))
                f.write('%s | %s | %.2f%%\n' % (p, stat[p], 1.0 * stat[p] / total * 100))

    
    def _set_reg(self, idx, value):
        self.R[idx] = value

    def _get_reg(self, idx):
        return self.R[idx]

    # def _to_int(self, arr):
    #     return ''.join(map(lambda x:'%02X' % x, arr[::-1]))

    # def _to_byte(self, s):
    #     return map(lambda x:int(''.join(x), 16), zip(*[iter('%08X' % int(s.rstrip('h'),16))]*2))[::-1]

    def _set_stack(self, offset, value):
        if offset < 0:
            raise TypeError("stack overflow")
        self.stack[offset/4] = value

    def _get_stack(self, offset, length = 4):
        if offset < 0:
            raise TypeError("stack overflow")
        return self.stack[offset/4]

    def _parse_val(self, s):
        s = s.strip()
        # return tuple(get(), set())
        def _err(s):
            _dbg("error %s" % s)

        def _1(b, a, s):
            b[a] = s

        if s.startswith('#') or s.startswith('=0x'):
            return lambda :int(s[1:], 16), lambda x:_err("can't set on imm")
        elif s.startswith('R'):
            _ = s.split(',')
            if len(_) > 1:
                # TODO only LSL is supported
                idx, lsl = map(int, re.findall('R(\d+),LSL#(\d+)', s)[0])
                return lambda idx=idx: self.R[idx] << lsl, lambda x, idx=idx: self._set_reg(idx, x)
            else:
                idx = int(s.lstrip('R'))
                return lambda idx=idx: self.R[idx], lambda x, idx=idx: self._set_reg(idx, x)
        elif s.startswith('['):
            if s == '[R3,R2,LSL#2]':
                return lambda :self.buffer[self.R[2]], lambda x:_1(self.buffer, self.R[2], x)
            try:
                base, offset = re.findall('\[R(\d+),#var_([\da-fA-F]+)\]', s)[0]
            except IndexError:
                # hard coded for base-addressing
                ad = self.R[int(s[2:-1])]
                pse_offset = ad % 0x1000
                n = self.mem_addr[ad - pse_offset]
                if pse_offset > 0:
                    pse_offset -= 1 # index start with 0
                # print(n, pse_offset)
                return lambda a=n:getattr(self, n)[pse_offset], lambda x, a=n:_1(getattr(self, n), pse_offset, x)
            else:
                offset = int(offset, 16)
                base = int(base)
                # hard coded R11 for stack pointer
                return lambda b=base, o=offset:self._get_stack(self.R[b] - o), lambda x, b=base, o=offset:self._set_stack(self.R[b] - o, x)
        elif s == 'SP':
            return lambda:self.SP, lambda x:setattr(self, 'SP', x)
        elif s.startswith('='):
            return lambda:self.mem_addr[s.lstrip('=')], lambda x:_err("can't set on ds")
        # ff, 00, 00, 00 for data segment


    def _addr(self, s):
        imm = re.findall('loc_([\dA-F]+)', s)
        if imm:
            return int(imm[0], 16)
        elif s in self.fun_alias:
            return self.fun_alias[s]

    def EXIT(self, *operand):
        self._exit = True

    def AEABI_IDIVMOD(self, *operand):
        #dst, src1, src2 = map(self._parse_val, operand[0].split(','))
        self.R[1] = self.R[0] % self.R[1]
        self.next_addr = self.jump_addr.pop()
   
    def ADD(self, *operand):
        dst, src1, src2 = map(self._parse_val, operand[0].split(','))
        dst[1](src1[0]() + src2[0]())

    def B(self, *operand):
        addr = self._addr(operand[0])
        self.next_addr = addr

    def BL(self, *operand):
        # save 
        addr = self._addr(operand[0])
        self.jump_addr.append(self.next_addr)
        self.next_addr = addr

    def BGE(self, *operand):
        if self.N == self.V:
            addr = self._addr(operand[0])
            self.next_addr = addr

    def BLE(self, *operand):
        if self.Z == 1 or self.N != self.V:
            addr = self._addr(operand[0])
            self.next_addr = addr

    def BLT(self, *operand):
        if self.N != self.V:
            addr = self._addr(operand[0])
            self.next_addr = addr

    def CMP(self, *operand):
        op1, op2 = map(self._parse_val, operand[0].split(', '))
        result = op1[0]() - op2[0]()
        if result == 0:
            self.N = 0
            self.Z = 1
            self.C = 0
            self.V = 0
        elif result > 0:
            self.N = 0
            self.Z = 0 
            self.C = 1
            self.V = 0
        elif result < 0:
            self.N = 1
            self.Z = 0 
            self.C = 0
            self.V = 0


    def LDMFD(self, *operand):
        addr = self.jump_addr.pop()
        if addr:
            self.next_addr = addr
        self.R[11] = self._get_stack(self.SP)
        # not finnished!

    def LDR(self, *operand):
        dst, src = map(self._parse_val, operand[0].split(', '))
        dst[1](src[0]())

    def MOV(self, *operand):
        dst, src = map(self._parse_val, operand[0].split(', '))
        dst[1](src[0]())

    def RSB(self, *operand):
        dst, src1, src2 = map(self._parse_val, operand[0].split(', '))
        dst[1](src2[0]() - src1[0]())

    def STMFD(self, *operand):
        #self.SP -= 4
        self._set_stack(self.SP, self.R[11])

    def STR(self, *operand):
        src, dst = map(self._parse_val, operand[0].split(', '))
        dst[1](src[0]())

    def SUB(self, *operand):
        dst, src1, src2 = map(self._parse_val, operand[0].split(', '))
        dst[1](src1[0]() - src2[0]())

emu = emu()
emu.run()