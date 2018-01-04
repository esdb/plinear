//+build !noasm !appengine

TEXT ·_CompareEqualByAvx(SB), $0-24

    MOVQ key+0(FP), DI
    MOVQ elements+8(FP), SI

    LONG $0xc76ef9c5 // vmovd  %edi,%xmm0
    LONG $0x5879e2c4; BYTE $0xc0 // vpbroadcastd %xmm0,%xmm0
    LONG $0x0e76f9c5 // vpcmpeqd (%rsi),%xmm0,%xmm1
    LONG $0x5676f9c5; BYTE $0x10 // vpcmpeqd 0x10(%rsi),%xmm0,%xmm2
    LONG $0x5e76f9c5; BYTE $0x20 // vpcmpeqd 0x20(%rsi),%xmm0,%xmm3
    LONG $0x6676f9c5; BYTE $0x30 // vpcmpeqd 0x30(%rsi),%xmm0,%xmm4
    LONG $0xca6bf1c5 // vpackssdw %xmm2,%xmm1,%xmm1
    LONG $0xd46be1c5 // vpackssdw %xmm4,%xmm3,%xmm2
    LONG $0xca63f1c5 // vpacksswb %xmm2,%xmm1,%xmm1
    LONG $0xc9d7f9c5 // vpmovmskb %xmm1,%ecx
    LONG $0x4e76f9c5; BYTE $0x40 // vpcmpeqd 0x40(%rsi),%xmm0,%xmm1
    LONG $0x5676f9c5; BYTE $0x50 // vpcmpeqd 0x50(%rsi),%xmm0,%xmm2
    LONG $0x5e76f9c5; BYTE $0x60 // vpcmpeqd 0x60(%rsi),%xmm0,%xmm3
    LONG $0x6676f9c5; BYTE $0x70 // vpcmpeqd 0x70(%rsi),%xmm0,%xmm4
    LONG $0xca6bf1c5 // vpackssdw %xmm2,%xmm1,%xmm1
    LONG $0xd46be1c5 // vpackssdw %xmm4,%xmm3,%xmm2
    LONG $0xca63f1c5 // vpacksswb %xmm2,%xmm1,%xmm1
    LONG $0xc1d7f9c5 // vpmovmskb %xmm1,%eax
    QUAD $0x000000808e76f9c5 // vpcmpeqd 0x80(%rsi),%xmm0,%xmm1
    QUAD $0x000000909676f9c5 // vpcmpeqd 0x90(%rsi),%xmm0,%xmm2
    QUAD $0x000000a09e76f9c5 // vpcmpeqd 0xa0(%rsi),%xmm0,%xmm3
    QUAD $0x000000b0a676f9c5 // vpcmpeqd 0xb0(%rsi),%xmm0,%xmm4
    LONG $0xca6bf1c5 // vpackssdw %xmm2,%xmm1,%xmm1
    LONG $0xd46be1c5 // vpackssdw %xmm4,%xmm3,%xmm2
    LONG $0xca63f1c5 // vpacksswb %xmm2,%xmm1,%xmm1
    LONG $0xd1d7f9c5 // vpmovmskb %xmm1,%edx
    QUAD $0x000000c08e76f9c5 // vpcmpeqd 0xc0(%rsi),%xmm0,%xmm1
    QUAD $0x000000d09676f9c5 // vpcmpeqd 0xd0(%rsi),%xmm0,%xmm2
    QUAD $0x000000e09e76f9c5 // vpcmpeqd 0xe0(%rsi),%xmm0,%xmm3
    QUAD $0x000000f08676f9c5 // vpcmpeqd 0xf0(%rsi),%xmm0,%xmm0
    LONG $0xca6bf1c5 // vpackssdw %xmm2,%xmm1,%xmm1
    LONG $0xc06be1c5 // vpackssdw %xmm0,%xmm3,%xmm0
    LONG $0xc063f1c5 // vpacksswb %xmm0,%xmm1,%xmm0
    LONG $0xf0d7f9c5 // vpmovmskb %xmm0,%esi
    LONG $0x30e6c148 // shl    $0x30,%rsi
    LONG $0x20e2c148 // shl    $0x20,%rdx
    LONG $0x10e0c148 // shl    $0x10,%rax
    WORD $0x0948; BYTE $0xc8 // or     %rcx,%rax
    WORD $0x0948; BYTE $0xd0 // or     %rdx,%rax
    WORD $0x0948; BYTE $0xf0 // or     %rsi,%rax
    MOVQ AX, ret+16(FP)
    RET


TEXT ·_CompareEqualByAvx2(SB), $0-24

    MOVQ key+0(FP), DI
    MOVQ elements+8(FP), SI

    LONG $0xc76ef9c5 // vmovd  %edi,%xmm0
    LONG $0x587de2c4; BYTE $0xc0 // vpbroadcastd %xmm0,%ymm0
    LONG $0x0e76fdc5 // vpcmpeqd (%rsi),%ymm0,%ymm1
    LONG $0x5676fdc5; BYTE $0x20 // vpcmpeqd 0x20(%rsi),%ymm0,%ymm2
    LONG $0x5e76fdc5; BYTE $0x40 // vpcmpeqd 0x40(%rsi),%ymm0,%ymm3
    QUAD $0x000000808676fdc5 // vpcmpeqd 0x80(%rsi),%ymm0,%ymm0
    LONG $0xca6bf5c5 // vpackssdw %ymm2,%ymm1,%ymm1
    LONG $0xc06be5c5 // vpackssdw %ymm0,%ymm3,%ymm0
    LONG $0xc063f5c5 // vpacksswb %ymm0,%ymm1,%ymm0
    LONG $0xc0d7fdc5 // vpmovmskb %ymm0,%eax
    VZEROUPPER
    MOVQ AX, ret+16(FP)
    RET
