assembly = '''
7328-  400560:  c5 f9 6e c7             vmovd  %edi,%xmm0
7378-  400564:  c4 e2 7d 58 c0          vpbroadcastd %xmm0,%ymm0
7435-  400569:  c5 fd 76 0e             vpcmpeqd (%rsi),%ymm0,%ymm1
7495-  40056d:  c5 fd 76 56 20          vpcmpeqd 0x20(%rsi),%ymm0,%ymm2
7559-  400572:  c5 fd 76 5e 40          vpcmpeqd 0x40(%rsi),%ymm0,%ymm3
7623-  400577:  c5 fd 76 86 80 00 00    vpcmpeqd 0x80(%rsi),%ymm0,%ymm0
7687-  40057e:  00
7701-  40057f:  c5 f5 6b ca             vpackssdw %ymm2,%ymm1,%ymm1
7761-  400583:  c5 e5 6b c0             vpackssdw %ymm0,%ymm3,%ymm0
7821-  400587:  c5 f5 63 c0             vpacksswb %ymm0,%ymm1,%ymm0
7881-  40058b:  c5 fd d7 c0             vpmovmskb %ymm0,%eax
7934-  40058f:  c5 f8 77                vzeroupper
'''

print(assembly)
lines = assembly.strip().splitlines()
i = 0
while True:
    if i >= len(lines):
        break
    line = lines[i]
    i += 1
    line = line[line.find(':') + 3:]
    byte1 = line[:2] if len(line) >= 2 else '  '
    byte2 = line[3:5] if len(line) >= 5 else '  '
    byte3 = line[6:8] if len(line) >= 8 else '  '
    byte4 = line[9:11] if len(line) >= 11 else '  '
    byte5 = line[12:14] if len(line) >= 14 else '  '
    byte6 = line[15:17] if len(line) >= 17 else '  '
    byte7 = line[18:20] if len(line) >= 20 else '  '
    if byte6 != '  ':
        comment = line[24:]
        line = lines[i]
        i += 1
        line = line[line.find(':') + 3:]
        byte8 = line[:2] if len(line) >= 2 else '  '
        print('    QUAD $0x%s%s%s%s%s%s%s%s // %s' % (byte8, byte7, byte6, byte5, byte4, byte3, byte2, byte1, comment))
    elif byte5 != '  ':
        print('    LONG $0x%s%s%s%s; BYTE $0x%s // %s' % (byte4, byte3, byte2, byte1, byte5, line[24:]))
    elif byte4 != '  ':
        print('    LONG $0x%s%s%s%s // %s' % (byte4, byte3, byte2, byte1, line[24:]))
    elif byte3 != '  ':
        print('    WORD $0x%s%s; BYTE $0x%s // %s' % (byte2, byte1, byte3, line[24:]))
