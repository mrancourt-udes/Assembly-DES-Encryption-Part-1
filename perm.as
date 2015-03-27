        .file   "perm.as"

/* Pgm: permutation
   auteur:  Vincent Ribou
            Martin Rancourt
            
*/
        .global perm
        .section ".text"

perm:   clr     %l0            ! initialisation du compteur de tableau

perm05:	ldub	[%i1+l0],%l2   ! chargement de l''index de permutation
		mov		1,%l3          ! bit de droite
		sub		%i2,%l2,%l2    ! nb entrees dans la table - index de permutation
		sllx	%l3,%l2,%l3    ! decalage vers la position finale

        and     %l3,%i0,%l3    ! recuperation du bit de depart
		xor		%l3,%o0,%o0    ! copie du bit dans la chaine de sortie

        cmp     %l0,i2         ! comparer cpt tableau avec nb elements tableau
		brne	perm05         ! fin du tableau ?
        inc     1,%l0