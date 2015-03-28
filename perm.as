.global Perm
/*  Perm   : sous-programme qui permute une chaine de bits.
    entree : %i0, la chaine de bits (le bit 1 aligne a gauche).
             %i1, l'adresse de la table de permutation.
             %i2, le nombre d'entrees dans la table de permutation.
    sortie : %o0: la chaine permutee (le bit 1 aligne a gauche).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/
        .section ".text"

Perm:   clr     %l0            ! initialisation du compteur de tableau

init:   mov     64,%i2
        setx    IP,%l7,%i1
        clr     %o3

perm05: 
        
        setx    ptfmt,%l7,%o0 ! 1er : adresse de la chaine a imprimer
        mov     %l0,%o1       ! 2em : valeur du compteur
        call    printf        ! imprimer les resultats
        nop

        ldub    [%i1+1],%l2   ! chargement de l''index de permutation
             
        mov     1,%l3          ! bit de droite
        sub     %i2,%l2,%l2    ! nb entrees dans la table - index de permutation
        sllx    %l3,%l2,%l3    ! decalage vers la position finale

        and     %l3,%i0,%l3    ! recuperation du bit de depart
        xor     %l3,%o3,%o3    ! copie du bit dans la chaine de sortie
        
        cmp     %l0,%i2        ! comparer cpt tableau avec nb elements tableau
        bne     perm05         ! fin du tableau ?
        inc     1,%l0

        setx    ptfmt,%l7,%o0  ! 1er : adresse de la chaine a imprimer
        mov     %o3,%o1        ! 2em : chaine permute
        call    printf         ! imprimer les resultats
        nop

        mov %o3,%o0            ! copie de la valeur de sortie temporaire dans %o0

        call    exit
        
        .section ".rodata"     ! section de donnees en lecture seulement
ptfmt: .asciz  "\n==============\nPERM.as - %u\n==============\n\n"

IP:     .byte   58,50,42,34,26,18,10,2
        .byte   60,52,44,36,28,20,12,4
        .byte   62,54,46,38,30,22,14,6
        .byte   64,56,48,40,32,24,16,8
        .byte   57,49,41,33,25,17,9,1
        .byte   59,51,43,35,27,19,11,3
        .byte   61,53,45,37,29,21,13,5
        .byte   63,55,47,39,31,23,15,7