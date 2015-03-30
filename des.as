        .global DES
/*  DES    : sous-programme d'encodage (Data Encryption Standard).
    entree : %i0, la chaine de 64 bits (le bit 1 aligne a gauche).
            %i1, la cle de 64 bits (le bit 1 aligne a gauche).
            %i2, l'adresse de la chaine de sortie (effectif si non nul).
    sortie : %o0, la chaine encodee de 64 bits (le bit 1 aligne a gauche).
    auteur:  Vincent Ribou et Martin Rancourt Universite de Sherbrooke, 2015.
*/

        .section ".text"

DES:    save    %sp,-208,%sp 
        setx    IP,%l7,%o1        ! chargement de l''adresse de la table IP
        mov     %i0,%o0           ! chaine de 64 bits
        mov     64,%o2            ! nb d''entrees dans la table de permutation
        call    Perm              ! permutation de la chaine de 64 bits

        srlx    %l1,32,%l1        ! 32 bit a gauche
        sllx    %i0,32,%l2        ! elimmination de ce qui a a droit des 32 bit de gauche
        srlx    %l2,32,%l2        ! 32 bit de droite

        mov     %i1,%o0           ! cle de 64 bit
        call    Key

        mov     15,%l3            ! nombre de cles a generer

des05:  mov     %l2,%o0           
        call    NextKey
        mov     %i0,%o1
        call    DESf


        xor     %i0,%l1,%l4       ! ou excluif entre la partie de gauche et resultat de f
        mov     %l2,%l1           ! inverse le cote gauche du droit
        mov     %l4,%l2


        dec     %l3
        brnz    %l3,des05         ! boucle
        nop

des10:  mov     %l2,%o0
        call    NextKey
        mov     %i0,%o1
        call    DESf

        xor     %i0,%l2,%l4         ! ou excluif entre la partie de gauche et resultat de f

        sllx    %l4,32,%l4          ! deplcament de 32 vers la gauche
        or      %l4,%l1,%o0

        setx    IP_1,%l7,%o1
        mov     64,%o2

        call    Perm
        mov     %i0,%o0

        ret
        restore %sp,-208,%sp


        .section ".rodata"      ! segment de donnees en lecture seulement
        .align  4
IP:     .byte   58,50,42,34,26,18,10,2
        .byte   60,52,44,36,28,20,12,4
        .byte   62,54,46,38,30,22,14,6
        .byte   64,56,48,40,32,24,16,8
        .byte   57,49,41,33,25,17,9,1
        .byte   59,51,43,35,27,19,11,3
        .byte   61,53,45,37,29,21,13,5
        .byte   63,55,47,39,31,23,15,7

        .align  4
IP_1:   .byte   40,8,48,16,56,24,64,32
        .byte   39,7,47,15,55,23,63,31
        .byte   38,6,46,14,54,22,62,30
        .byte   37,5,45,13,53,21,61,29
        .byte   36,4,44,12,52,20,60,28
        .byte   35,3,43,11,51,19,59,27
        .byte   34,2,42,10,50,18,58,26
        .byte   33,1,41,9,49,17,57,25

        .align  4
E:      .byte   32,1,2,3,4,5
        .byte   4,5,6,7,8,9
        .byte   8,9,10,11,12,13
        .byte   12,13,14,15,16,17
        .byte   16,17,18,19,20,21
        .byte   20,21,22,23,24,25
        .byte   24,25,26,27,28,29
        .byte   28,29,30,31,32,1

        .align  4
P:      .byte   16,7,20,21
        .byte   29,12,28,17
        .byte   1,15,23,26
        .byte   5,18,31,10
        .byte   2,8,24,14
        .byte   32,27,3,9
        .byte   19,13,30,6
        .byte   22,11,4,25

        .align  4
S1:     .byte   14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7
        .byte   0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8
        .byte   4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0
        .byte   15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13

        .align  4
S2:     .byte   15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10
        .byte   3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5
        .byte   0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15
        .byte   13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9

        .align  4
S3:     .byte   10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8
        .byte   13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1
        .byte   13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7
        .byte   1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12

        .align  4
S4:     .byte   7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15
        .byte   13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9
        .byte   10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4
        .byte   3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14

        .align  4
S5:     .byte   2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9
        .byte   14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6
        .byte   4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14
        .byte   11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3

        .align  4
S6:     .byte   12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11
        .byte   10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8
        .byte   9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6
        .byte   4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13

        .align  4
S7:     .byte   4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1
        .byte   13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6
        .byte   1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2
        .byte   6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12

        .align  4
S8:     .byte   13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7
        .byte   1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2
        .byte   7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8
        .byte   2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11

        .align  4
PC_1:   .byte   57,49,41,33,25,17,9
        .byte   1,58,50,42,34,26,18
        .byte   10,2,59,51,43,35,27
        .byte   19,11,3,60,52,44,36
        .byte   63,55,47,39,31,23,15
        .byte   7,62,54,46,38,30,22
        .byte   14,6,61,53,45,37,29
        .byte   21,13,5,28,20,12,4

        .align  4
PC_2:   .byte   14,17,11,24,1,5 
        .byte   3,28,15,6,21,10
        .byte   23,19,12,4,26,8
        .byte   16,7,27,20,13,2
        .byte   41,52,31,37,47,55
        .byte   30,40,51,45,33,48
        .byte   44,49,39,56,34,53
        .byte   46,42,50,36,29,32

        .align  4
LS:     .byte   1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1


