        .global Perm
/*  Perm   : sous-programme qui permute une chaine de bits.
    entree : %i0, la chaine de bits (le bit 1 aligne a gauche).
             %i1, l'adresse de la table de permutation.
             %i2, le nombre d'entrees dans la table de permutation.
    sortie : %o0: la chaine permutee (le bit 1 aligne a gauche).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/
        .section ".text"

Perm:  
        save    %sp,-208,%sp

        clr     %l0                 ! initialisation du compteur de tableau 
        clr     %l3                 ! valeur de sortie : a transferer dans %o0
      
perm05: 
        
        ldub    [%i1+%l0],%l2       ! chargement de l''index de permutation
        inc     1,%l0               ! index dans la table

        sub     %i2,%l2,%l1         ! position du bit a recuperer
        sub     %l2,%l0,%l5         ! index de permutation - index effectif : indice de decalage

        mov     1,%l4               ! initialisation du bit du mask 
        sllx    %l4,%l1,%l1         ! decalage du bit vers la position du bit a recuperer

        and     %l1,%i0,%l1         ! recuperation de la valeur du bit courent
        cmp     %l5,%g0
        bneg    %xcc,perm15
        nop

perm10:                             ! decalage positif
        sllx    %l1,%l5,%l1

        ba      perm20
        nop

perm15:                             ! decalage negatif
        neg     %l5,%l5             
        srlx    %l1,%l5,%l1

perm20:     

        or     %l3,%l1,%l3

        cmp     %l0,%i2             ! cmp index tableau avec nb elements tableau
        bne     perm05              ! fin du tableau ?
        nop

        mov     %l3,%i0             ! copie de la valeur de sortie temporaire dans %o0

        ret
        restore