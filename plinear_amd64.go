package plinear

import (
	"unsafe"
)

//go:noescape
func _CompareEqualByAvx(key uint32, elements unsafe.Pointer) (ret uint64)

func CompareEqualByAvx(key uint32, elements *[64]uint32) (ret uint64) {
	return _CompareEqualByAvx(key, unsafe.Pointer(elements))
}