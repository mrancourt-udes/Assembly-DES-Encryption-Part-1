perm00:	mov		%i2,%l1

perm05:	ldub	[%i1],%l2
		mov		1,%l3
		sub		%l1,%l2,%l2
		sllx	%l3,%l2,%l3

		bset	%l3,%l4
		xor		%l4,%i2,%o0

		dec		%l2
		brnz	%l2
