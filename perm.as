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

        setx    ptfmtxx,%l7,%o0     ! 1er : adresse de la chaine a imprimer
        mov     %i0,%o2             ! 2em : chaine permute
        srlx    %o2,32,%o1          ! 2em : chaine permute
        call    printf              ! imprimer les resultats
        nop


perm05: 
        
        ldub    [%i1+%l0],%l2       ! chargement de l''index de permutation
        inc     1,%l0               ! index dans la table

        sub     %i2,%l0,%l1         ! nb elements - index table : position du bit courant
        
        mov     1,%l4               ! initialisation du bit du mask 
        sllx    %l4,%l1,%l1         ! decalage du bit vers la position du bit courant
        and     %l1,%i0,%l1         ! recuperation de la valeur du bit courent

        sub     %l2,%l0,%l4         ! index de permutation - index effectif : indice de decalage

        cmp     %l4,%g0
        bneg    %xcc,perm15

perm10:                             ! decalage positif
        srlx    %l1,%l4,%l1

        ba      perm20
        nop

perm15:                             ! decalage negatif
        neg     %l4,%l4             
        sllx    %l1,%l4,%l1

perm20:     
        xor     %l1,%l3,%l3

        cmp     %l0,%i2             ! cmp index tableau avec nb elements tableau
        bne     perm05              ! fin du tableau ?
        nop 

        mov     %l3,%i0             ! copie de la valeur de sortie temporaire dans %o0

        setx    ptfmtxx,%l7,%o0     ! 1er : adresse de la chaine a imprimer
        mov     %i0,%o2             ! 2em : 32 bits de gauche
        srlx    %o2,32,%o1          ! 2em : 32 bits de droite
        call    printf              ! imprimer les resultats
        nop

        call exit

        .section ".rodata"          ! section de donnees en lecture seulement

ptfmtd: .asciz "%d\n"
ptfmtxx:.asciz "%08x%08x\n"

        .align  8
I0:     .xword  0x3fa40e8a984d4815