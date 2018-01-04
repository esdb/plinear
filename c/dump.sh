clang -O3 -mavx2 -mfma -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions -fno-rtti plinear.c
objdump -d a.out | grep -b60 CompareEqualByAvx