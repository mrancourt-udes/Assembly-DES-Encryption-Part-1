        .global subs
/*  Subs   : sous-programme qui substitue une chaine de 6 bits par
             une chaine de 4 bits.
    entree : %i0, la chaine de 6 bits (le bit 6 aligne a droite).
             %i1, l’adresse de la table de substitution.
    sortie : %o0, la chaine de 4 bits (le bit 4 aligne a droite).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/

        .section ".text"

subs:   mov     0x20,%l1        ! mask : 100000
        xor     %l1,%i0,%l1     ! recuperation du dernier bit de gauche
        srlx    %l1,4,%l1       ! decalage du bit vers : 0000*0

        mov     1,%l2           ! mask : 000001
        xor     %l2,i0%l2       ! recuperation le premier bit a droite

        xor     %l1,%l2,%l3     ! deux bit concatene 0000** (i)

        mov     0x1E,%l2        ! creation d’un masque 011110
        xor     %l2,%i0,%l2     ! recuperation des 4 bits du centre
        srlx    %l2,1,%l2       ! valeur reelle des 4 bits du centre (j)

                                ! calcul de ladresse dans le tableau
                                ! alpha + ((i-1)*N+(j-1)
        dec     1,%l3           ! i-1
        mulx    %l3,4,%l3       ! (i-1)*4
        dec     1,%l2           ! j-1
        add     %l2,%l3,%l2     ! ((i-1)*N+(j-1)
        add     %i2,%l2,%l2     ! alpha + ((i-1)*N+(j-1)

        ldub    [%l2],%o0       ! chargement de la valeur contenu dans le tableau