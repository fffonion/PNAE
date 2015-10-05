PNAE
====
PNAE's Not ARM Emultor

This is a project try to emulate ARM CPU in Python. Till now it's still at a  very early stage.

### What is supported
- Run snippet of code or function
- Call functions
- Basic memory operation, jump
- Partial of ARM instruction sets is supported. But new instruction can be easily added.
- push/pop to stack must be 32bit width.

### What is no supported
- System call
- Library call
- Thumb, neon, etc.
- Automatic static variable recognization(must be hard coded)

### How to run
    python ./emu.py
This will take **qsort-fix.asm** as an input.

This emulator not comes up with ELF or PE file reading ability. You should feed it with an assembly listing or use something like IDA Pro to generate assembly file.

## How to add instructions
There're `self.R[0:15]` as registers and four flags `N`, `Z`, `C`, `V`. Stack is `self.stack`.
Example:

    ADCHI   r11,r0,r3       ; only executed if C flag set and Z
                            ; flag clear

```Python
def ADCHI(self, *operand):
    if self.C and not self.Z:
        # parse operands
        dst, src1, src2 = map(self._parse_val, operand[0].split(', '))
        dst[1]( # lambda function to "set" to dst
            # lambda function to "get" src1
            src1[0]() + \
            # lambda function to "get" src2
            src2[0]() 
        )
```