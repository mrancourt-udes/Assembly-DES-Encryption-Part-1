        .global Subs
/*  Subs   : sous-programme qui substitue une chaine de 6 bits par
             une chaine de 4 bits.
    entree : %i0, la chaine de 6 bits (le bit 6 aligne a droite).
             %i1, l'adresse de la table de substitution.
    sortie : %o0, la chaine de 4 bits (le bit 4 aligne a droite).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/

        .section ".text"

Subs:   
        save    %sp,-208,%sp

        mov     0x20,%l1        ! mask : 100000

        and     %l1,%i0,%l1     ! recuperation du dernier bit derniere gauche
        srlx    %l1,4,%l1       ! decalage du bit vers : 0000*0

        mov     1,%l2           ! mask : 000001
        and     %l2,%i0,%l2     ! recuperation le premier bit a droite

        xor     %l1,%l2,%l3     ! deux bit concatene 0000** (i)

        mov     0x1E,%l2        ! creation d''un masque 011110
        and     %l2,%i0,%l2     ! recuperation des 4 bits du centre
        srlx    %l2,1,%l2       ! valeur reelle des 4 bits du centre (j)

                                ! calcul de ladresse dans le tableau
                                ! alpha + i*N+j
        mulx    %l3,16,%l3      ! i*16
        add     %l2,%l3,%l2     ! i*N+j
        add     %i1,%l2,%l2     ! alpha + i*N+j

        ldub    [%l2],%i0       ! chargement de la valeur contenu dans le tableau

        ret
        restore