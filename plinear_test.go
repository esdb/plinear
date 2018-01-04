package plinear

import (
	"testing"
	"github.com/esdb/biter"
	"github.com/stretchr/testify/require"
)

func TestCompareEqualByAvx(t *testing.T) {
	should := require.New(t)
	v1 := [64]uint32{
		3, 0, 0, 3, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 3, 3}
	ret := CompareEqualByAvx(3, &v1)
	result := biter.Bits(ret)
	iter := result.ScanBackward()
	should.Equal(biter.Slot(0), iter())
	should.Equal(biter.Slot(3), iter())
	should.Equal(biter.Slot(62), iter())
	should.Equal(biter.Slot(63), iter())
}

func BenchmarkCompareEqualByAvx(b *testing.B) {
	v1 := [64]uint32{
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 3, 3}
	for i := 0; i < b.N; i++ {
		CompareEqualByAvx(3, &v1)
	}
}

func naiveCompareEQ(key uint32, v *[64]uint32) uint64 {
	for i, ele := range v {
		if ele == key {
			return uint64(i)
		}
	}
	return 64
}

func BenchmarkNaiveCompareEQ(b *testing.B) {
	v1 := [64]uint32{
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 3, 3}
	for i := 0; i < b.N; i++ {
		naiveCompareEQ(3, &v1)
	}
}
