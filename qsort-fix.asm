.text:00008464 ; int __cdecl main(int argc, const char **argv, const char **envp)
.text:00008464                 EXPORT main
.text:00008464 main                                    ; DATA XREF: _start+20o
.text:00008464                                         ; .text:off_8374o
.text:00008464
.text:00008464 var_10          = -0x10
.text:00008464 var_C           = -0xC
.text:00008464 var_8           = -8
.text:00008464
.text:00008464                 STMFD           SP!, {R11,LR}
.text:00008468                 ADD             R11, SP, #4
.text:0000846C                 SUB             SP, SP, #0x10
.text:00008470                 MOV             R3, #0
.text:00008474                 STR             R3, [R11,#var_8]
.text:00008478                 B               loc_84F0
.text:0000847C ; ---------------------------------------------------------------------------
.text:0000847C
.text:0000847C loc_847C                                ; CODE XREF: main+94j
.text:0000847C                 MOV             R3, #0
.text:00008480                 STR             R3, [R11,#var_C]
.text:00008484                 B               loc_84C8
.text:00008488 ; ---------------------------------------------------------------------------
.text:00008488
.text:00008488 loc_8488                                ; CODE XREF: main+6Cj
.text:00008488                 MOV             R0, #0x20000
.text:0000848C                 BL              random
.text:00008490                 STR             R0, [R11,#var_10]
.text:00008494                 LDR             R3, [R11,#var_10]
.text:00008498                 CMP             R3, #0
.text:0000849C                 BGE             loc_84AC
.text:000084A0                 LDR             R3, [R11,#var_10]
.text:000084A4                 RSB             R3, R3, #0
.text:000084A8                 STR             R3, [R11,#var_10]
.text:000084AC
.text:000084AC loc_84AC                                ; CODE XREF: main+38j
.text:000084AC                 LDR             R3, =buffer
.text:000084B0                 LDR             R2, [R11,#var_C]
.text:000084B4                 LDR             R1, [R11,#var_10]
.text:000084B8                 STR             R1, [R3,R2,LSL#2]
.text:000084BC                 LDR             R3, [R11,#var_C]
.text:000084C0                 ADD             R3, R3, #1
.text:000084C4                 STR             R3, [R11,#var_C]
.text:000084C8
.text:000084C8 loc_84C8                                ; CODE XREF: main+20j
.text:000084C8                 LDR             R3, [R11,#var_C]
.text:000084CC                 CMP             R3, #0x7cf
.text:000084D0                 BLT             loc_8488
.text:000084D4                 MOV             R0, #0
.text:000084D8                 LDR             R1, =0x7d0
.text:000084DC                 LDR             R2, =buffer
.text:000084E0                 BL              quick
.text:000084E4                 LDR             R3, [R11,#var_8]
.text:000084E8                 ADD             R3, R3, #1
.text:000084EC                 STR             R3, [R11,#var_8]
.text:000084F0
.text:000084F0 loc_84F0                                ; CODE XREF: main+14j
.text:000084F0                 LDR             R3, [R11,#var_8]
.text:000084F4                 CMP             R3, #0x63
.text:000084F8                 BLE             loc_847C
.text:000084FC                 MOV             R0, #0  ; status
.text:00008500                 BL              exit
.text:00008500 ; End of function main
.text:00008500
.text:00008500 ; ---------------------------------------------------------------------------
.text:00008504 off_8504        DCD buffer              ; DATA XREF: main:loc_84ACr
.text:00008504                                         ; main+78r
.text:00008508 dword_8508      DCD 0x7CF               ; DATA XREF: main+74r
.text:0000850C
.text:0000850C ; =============== S U B R O U T I N E =======================================
.text:0000850C
.text:0000850C ; Attributes: bp-based frame
.text:0000850C
.text:0000850C                 EXPORT quick
.text:0000850C quick                                   ; CODE XREF: main+7Cp
.text:0000850C                                         ; quick+1ECp ...
.text:0000850C
.text:0000850C var_20          = -0x20
.text:0000850C var_1C          = -0x1C
.text:0000850C var_18          = -0x18
.text:0000850C var_14          = -0x14
.text:0000850C var_10          = -0x10
.text:0000850C var_C           = -0xC
.text:0000850C var_8           = -8
.text:0000850C
.text:0000850C                 STMFD           SP!, {R11,LR}
.text:00008510                 ADD             R11, SP, #4
.text:00008514                 SUB             SP, SP, #0x20
.text:00008518                 STR             R0, [R11,#var_18]
.text:0000851C                 STR             R1, [R11,#var_1C]
.text:00008520                 STR             R2, [R11,#var_20]
.text:00008524                 LDR             R2, [R11,#var_18]
.text:00008528                 LDR             R3, [R11,#var_1C]
.text:0000852C                 CMP             R2, R3
.text:00008530                 BGE             loc_8714
.text:00008534                 LDR             R3, [R11,#var_18]
.text:00008538                 STR             R3, [R11,#var_8]
.text:0000853C                 LDR             R3, [R11,#var_1C]
.text:00008540                 SUB             R3, R3, #1
.text:00008544                 STR             R3, [R11,#var_C]
.text:00008548                 LDR             R3, [R11,#var_1C]
.text:0000854C                 MOV             R3, R3 ;,LSL#2
.text:00008550                 LDR             R2, [R11,#var_20]
.text:00008554                 ADD             R3, R2, R3
.text:00008558                 LDR             R3, [R3]
.text:0000855C                 STR             R3, [R11,#var_10]
.text:00008560                 B               loc_863C
.text:00008564 ; ---------------------------------------------------------------------------
.text:00008564
.text:00008564 loc_8564                                ; CODE XREF: quick+13Cj
.text:00008564                 B               loc_8574
.text:00008568 ; ---------------------------------------------------------------------------
.text:00008568
.text:00008568 loc_8568                                ; CODE XREF: quick+94j
.text:00008568                 LDR             R3, [R11,#var_8]
.text:0000856C                 ADD             R3, R3, #1
.text:00008570                 STR             R3, [R11,#var_8]
.text:00008574
.text:00008574 loc_8574                                ; CODE XREF: quick:loc_8564j
.text:00008574                 LDR             R2, [R11,#var_8]
.text:00008578                 LDR             R3, [R11,#var_C]
.text:0000857C                 CMP             R2, R3
.text:00008580                 BGE             loc_85A4
.text:00008584                 LDR             R3, [R11,#var_8]
.text:00008588                 MOV             R3, R3 ;,LSL#2
.text:0000858C                 LDR             R2, [R11,#var_20]
.text:00008590                 ADD             R3, R2, R3
.text:00008594                 LDR             R2, [R3]
.text:00008598                 LDR             R3, [R11,#var_10]
.text:0000859C                 CMP             R2, R3
.text:000085A0                 BLT             loc_8568
.text:000085A4
.text:000085A4 loc_85A4                                ; CODE XREF: quick+74j
.text:000085A4                 B               loc_85B4
.text:000085A8 ; ---------------------------------------------------------------------------
.text:000085A8
.text:000085A8 loc_85A8                                ; CODE XREF: quick+D4j
.text:000085A8                 LDR             R3, [R11,#var_C]
.text:000085AC                 SUB             R3, R3, #1
.text:000085B0                 STR             R3, [R11,#var_C]
.text:000085B4
.text:000085B4 loc_85B4                                ; CODE XREF: quick:loc_85A4j
.text:000085B4                 LDR             R2, [R11,#var_C]
.text:000085B8                 LDR             R3, [R11,#var_8]
.text:000085BC                 CMP             R2, R3
.text:000085C0                 BLE             loc_85E4
.text:000085C4                 LDR             R3, [R11,#var_C]
.text:000085C8                 MOV             R3, R3 ;,LSL#2
.text:000085CC                 LDR             R2, [R11,#var_20]
.text:000085D0                 ADD             R3, R2, R3
.text:000085D4                 LDR             R2, [R3]
.text:000085D8                 LDR             R3, [R11,#var_10]
.text:000085DC                 CMP             R2, R3
.text:000085E0                 BGE             loc_85A8
.text:000085E4
.text:000085E4 loc_85E4                                ; CODE XREF: quick+B4j
.text:000085E4                 LDR             R3, [R11,#var_8]
.text:000085E8                 MOV             R3, R3 ;,LSL#2
.text:000085EC                 LDR             R2, [R11,#var_20]
.text:000085F0                 ADD             R3, R2, R3
.text:000085F4                 LDR             R3, [R3]
.text:000085F8                 STR             R3, [R11,#var_14]
.text:000085FC                 LDR             R3, [R11,#var_8]
.text:00008600                 MOV             R3, R3 ;,LSL#2
.text:00008604                 LDR             R2, [R11,#var_20]
.text:00008608                 ADD             R3, R2, R3
.text:0000860C                 LDR             R2, [R11,#var_C]
.text:00008610                 MOV             R2, R2 ;,LSL#2
.text:00008614                 LDR             R1, [R11,#var_20]
.text:00008618                 ADD             R2, R1, R2
.text:0000861C                 LDR             R2, [R2]
.text:00008620                 STR             R2, [R3]
.text:00008624                 LDR             R3, [R11,#var_C]
.text:00008628                 MOV             R3, R3 ;,LSL#2
.text:0000862C                 LDR             R2, [R11,#var_20]
.text:00008630                 ADD             R3, R2, R3
.text:00008634                 LDR             R2, [R11,#var_14]
.text:00008638                 STR             R2, [R3]
.text:0000863C
.text:0000863C loc_863C                                ; CODE XREF: quick+54j
.text:0000863C                 LDR             R2, [R11,#var_8]
.text:00008640                 LDR             R3, [R11,#var_C]
.text:00008644                 CMP             R2, R3
.text:00008648                 BLT             loc_8564
.text:0000864C                 LDR             R3, [R11,#var_8]
.text:00008650                 MOV             R3, R3 ;,LSL#2
.text:00008654                 LDR             R2, [R11,#var_20]
.text:00008658                 ADD             R3, R2, R3
.text:0000865C                 LDR             R2, [R3]
.text:00008660                 LDR             R3, [R11,#var_1C]
.text:00008664                 MOV             R3, R3 ;,LSL#2
.text:00008668                 LDR             R1, [R11,#var_20]
.text:0000866C                 ADD             R3, R1, R3
.text:00008670                 LDR             R3, [R3]
.text:00008674                 CMP             R2, R3
.text:00008678                 BLT             loc_86D8
.text:0000867C                 LDR             R3, [R11,#var_8]
.text:00008680                 MOV             R3, R3 ;,LSL#2
.text:00008684                 LDR             R2, [R11,#var_20]
.text:00008688                 ADD             R3, R2, R3
.text:0000868C                 LDR             R3, [R3]
.text:00008690                 STR             R3, [R11,#var_14]
.text:00008694                 LDR             R3, [R11,#var_8]
.text:00008698                 MOV             R3, R3 ;,LSL#2
.text:0000869C                 LDR             R2, [R11,#var_20]
.text:000086A0                 ADD             R3, R2, R3
.text:000086A4                 LDR             R2, [R11,#var_1C]
.text:000086A8                 MOV             R2, R2 ;,LSL#2
.text:000086AC                 LDR             R1, [R11,#var_20]
.text:000086B0                 ADD             R2, R1, R2
.text:000086B4                 LDR             R2, [R2]
.text:000086B8                 STR             R2, [R3]
.text:000086BC                 LDR             R3, [R11,#var_1C]
.text:000086C0                 MOV             R3, R3 ;,LSL#2
.text:000086C4                 LDR             R2, [R11,#var_20]
.text:000086C8                 ADD             R3, R2, R3
.text:000086CC                 LDR             R2, [R11,#var_14]
.text:000086D0                 STR             R2, [R3]
.text:000086D4                 B               loc_86E4
.text:000086D8 ; ---------------------------------------------------------------------------
.text:000086D8
.text:000086D8 loc_86D8                                ; CODE XREF: quick+16Cj
.text:000086D8                 LDR             R3, [R11,#var_8]
.text:000086DC                 ADD             R3, R3, #1
.text:000086E0                 STR             R3, [R11,#var_8]
.text:000086E4
.text:000086E4 loc_86E4                                ; CODE XREF: quick+1C8j
.text:000086E4                 LDR             R3, [R11,#var_8]
.text:000086E8                 SUB             R3, R3, #1
.text:000086EC                 LDR             R0, [R11,#var_18]
.text:000086F0                 MOV             R1, R3
.text:000086F4                 LDR             R2, [R11,#var_20]
.text:000086F8                 BL              quick
.text:000086FC                 LDR             R3, [R11,#var_8]
.text:00008700                 ADD             R3, R3, #1
.text:00008704                 MOV             R0, R3
.text:00008708                 LDR             R1, [R11,#var_1C]
.text:0000870C                 LDR             R2, [R11,#var_20]
.text:00008710                 BL              quick
.text:00008714
.text:00008714 loc_8714                                ; CODE XREF: quick+24j
.text:00008714                 MOV             R0, R3
.text:00008718                 SUB             SP, R11, #4
.text:0000871C                 LDMFD           SP!, {R11,PC}
.text:0000871C ; End of function quick
.text:0000871C
.text:00008720
.text:00008720 ; =============== S U B R O U T I N E =======================================
.text:00008720
.text:00008720 ; Attributes: bp-based frame
.text:00008720
.text:00008720                 EXPORT random
.text:00008720 random                                  ; CODE XREF: main+28p
.text:00008720
.text:00008720 var_8           = -8
.text:00008720
.text:00008720                 STMFD           SP!, {R11,LR}
.text:00008724                 ADD             R11, SP, #4
.text:00008728                 SUB             SP, SP, #8
.text:0000872C                 STR             R0, [R11,#var_8]
.text:00008730                 LDR             R3, =seed
.text:00008734                 LDR             R2, [R3]
.text:00008738                 MOV             R3, R2
.text:0000873C                 MOV             R3, R3,LSL#3
.text:00008740                 RSB             R3, R2, R3
.text:00008744                 MOV             R3, R3,LSL#2
.text:00008748                 ADD             R3, R3, R2
.text:0000874C                 MOV             R1, R3,LSL#3
.text:00008750                 RSB             R1, R3, R1
.text:00008754                 MOV             R3, R1,LSL#5
.text:00008758                 RSB             R3, R1, R3
.text:0000875C                 MOV             R3, R3,LSL#2
.text:00008760                 ADD             R3, R3, R2
.text:00008764                 ADD             R3, R3, #0x3600
.text:00008768                 ADD             R3, R3, #0x19
.text:0000876C                 LDR             R2, =seed
.text:00008770                 STR             R3, [R2]
.text:00008774                 LDR             R3, =seed
.text:00008778                 LDR             R3, [R3]
.text:0000877C                 MOV             R0, R3
.text:00008780                 LDR             R1, [R11,#var_8]
.text:00008784                 BL              __aeabi_idivmod
.text:00008788                 MOV             R3, R1
.text:0000878C                 MOV             R0, R3
.text:00008790                 SUB             SP, R11, #4
.text:00008794                 LDMFD           SP!, {R11,PC}
.text:00008794 ; End of function random
.text:00008794
.text:00008794 ; ---------------------------------------------------------------------------
.text:00008798 off_8798        DCD seed                ; DATA XREF: random+10r
.text:00008798                                         ; random+4Cr ...