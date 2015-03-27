des00:	setx	IP,%l7,%o1
		mov		%i0,o0
		mov		64,%o2
		call	Perm

		srlx	%io,32,%l1	! 32 bit a gauche
		sllx	%i0,32,%l2	! elimmination de ce qui a a droit des 32 bit de gauche
		srlx	%l2,32,%l2	! 32 bit de droite

		mov		%i1,%o0		! cle de 64 bit
		call	Key

		mov 	14,%l3		! initialisation iterateur pour faire 15 cle

des05:	mov		%l2,%o0
		call	NextKey
		mov		%i0,%o1
		call	DESf

		xor		%i0,%l1,%l2	! ou excluif entre la partie de gauche et resultat de f
		mov		%l2,%l1		! inverse le cote gauche du droit

		dec		%l3
		brnz	%l3,des05	! boucle
		nop

des10:	mov		%l2,%o0
		call	NextKey
		mov		%l0,%o1
		call	desf

		xor		%i0,%l2,%l4

		dllx	%l4,32,%l4
		or		%l4,%l1,%o0

		setx	IP_1,%l7,%o1
		mov		64,%o2

		call	PERM
		mov		%i0,%o0