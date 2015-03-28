.global perm
/*  Perm   : sous-programme qui permute une chaine de bits.
    entree : %i0, la chaine de bits (le bit 1 aligne a gauche).
             %i1, l'adresse de la table de permutation.
             %i2, le nombre d'entrees dans la table de permutation.
    sortie : %o0: la chaine permutee (le bit 1 aligne a gauche).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/
        .section ".text"

perm:   clr     %l0            ! initialisation du compteur de tableau

perm05: ldub    [%i1+%l0],%l2   ! chargement de l''index de permutation
        mov     1,%l3          ! bit de droite
        sub     %i2,%l2,%l2    ! nb entrees dans la table - index de permutation
        sllx    %l3,%l2,%l3    ! decalage vers la position finale

        and     %l3,%i0,%l3    ! recuperation du bit de depart
        xor     %l3,%o0,%o0    ! copie du bit dans la chaine de sortie

        cmp     %l0,%i2         ! comparer cpt tableau avec nb elements tableau
        bne     perm05         ! fin du tableau ?
        inc     1,%l0