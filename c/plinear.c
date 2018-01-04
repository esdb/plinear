#include <immintrin.h>
#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

static uint64_t combine16(uint16_t m1, uint16_t m2, uint16_t m3, uint16_t m4) {
     return (((uint64_t) m4) << 48) | (((uint64_t) m3) << 32) | (((uint64_t) m2) << 16) | ((uint64_t) m1);
}

uint64_t CompareEqualByAvx(uint32_t key, const uint32_t *elements)  {
    __m128i key4 = _mm_set1_epi32(key);
    const __m128i v1 = _mm_loadu_si128((const __m128i *)elements);
    const __m128i v2 = _mm_loadu_si128((const __m128i *)(elements + 4));
    const __m128i v3 = _mm_loadu_si128((const __m128i *)(elements + 8));
    const __m128i v4 = _mm_loadu_si128((const __m128i *)(elements + 12));

    const __m128i cmp1 = _mm_cmpeq_epi32(key4, v1);
    const __m128i cmp2 = _mm_cmpeq_epi32(key4, v2);
    const __m128i cmp3 = _mm_cmpeq_epi32(key4, v3);
    const __m128i cmp4 = _mm_cmpeq_epi32(key4, v4);

    const __m128i pack12 = _mm_packs_epi32(cmp1, cmp2);
    const __m128i pack34 = _mm_packs_epi32(cmp3, cmp4);
    const __m128i pack1234 = _mm_packs_epi16(pack12, pack34);
    const uint16_t mask1 = _mm_movemask_epi8(pack1234);

    const __m128i v5 = _mm_loadu_si128((const __m128i *)(elements + 16));
    const __m128i v6 = _mm_loadu_si128((const __m128i *)(elements + 20));
    const __m128i v7 = _mm_loadu_si128((const __m128i *)(elements + 24));
    const __m128i v8 = _mm_loadu_si128((const __m128i *)(elements + 28));

    const __m128i cmp5 = _mm_cmpeq_epi32(key4, v5);
    const __m128i cmp6 = _mm_cmpeq_epi32(key4, v6);
    const __m128i cmp7 = _mm_cmpeq_epi32(key4, v7);
    const __m128i cmp8 = _mm_cmpeq_epi32(key4, v8);

    const __m128i pack56 = _mm_packs_epi32(cmp5, cmp6);
    const __m128i pack78 = _mm_packs_epi32(cmp7, cmp8);
    const __m128i pack5678 = _mm_packs_epi16(pack56, pack78);
    const uint16_t mask2 = _mm_movemask_epi8(pack5678);

    const __m128i v9 = _mm_loadu_si128((const __m128i *)(elements + 32));
    const __m128i v10 = _mm_loadu_si128((const __m128i *)(elements + 36));
    const __m128i v11 = _mm_loadu_si128((const __m128i *)(elements + 40));
    const __m128i v12 = _mm_loadu_si128((const __m128i *)(elements + 44));

    const __m128i cmp9 = _mm_cmpeq_epi32(key4, v9);
    const __m128i cmp10 = _mm_cmpeq_epi32(key4, v10);
    const __m128i cmp11 = _mm_cmpeq_epi32(key4, v11);
    const __m128i cmp12 = _mm_cmpeq_epi32(key4, v12);

    const __m128i pack910 = _mm_packs_epi32(cmp9, cmp10);
    const __m128i pack1112 = _mm_packs_epi32(cmp11, cmp12);
    const __m128i pack9101112 = _mm_packs_epi16(pack910, pack1112);
    const uint16_t mask3 = _mm_movemask_epi8(pack9101112);

    const __m128i v13 = _mm_loadu_si128((const __m128i *)(elements + 48));
    const __m128i v14 = _mm_loadu_si128((const __m128i *)(elements + 52));
    const __m128i v15 = _mm_loadu_si128((const __m128i *)(elements + 56));
    const __m128i v16 = _mm_loadu_si128((const __m128i *)(elements + 60));

    const __m128i cmp13 = _mm_cmpeq_epi32(key4, v13);
    const __m128i cmp14 = _mm_cmpeq_epi32(key4, v14);
    const __m128i cmp15 = _mm_cmpeq_epi32(key4, v15);
    const __m128i cmp16 = _mm_cmpeq_epi32(key4, v16);

    const __m128i pack1314 = _mm_packs_epi32(cmp13, cmp14);
    const __m128i pack1516 = _mm_packs_epi32(cmp15, cmp16);
    const __m128i pack13141516 = _mm_packs_epi16(pack1314, pack1516);
    const uint16_t mask4 = _mm_movemask_epi8(pack13141516);
    return combine16(mask1, mask2, mask3, mask4);
}

int main() {
    uint32_t key = 3;
    uint32_t array[64] = {
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,3,
    };
    uint64_t mask = CompareEqualByAvx(key, array);
    printf("%" PRIu64 "\n", mask);
    return 0;
}
