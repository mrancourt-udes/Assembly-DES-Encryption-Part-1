        .global main

/* main   : programme pour l'appel des sous-programmes DES et DESinv.

   Auteur : Richard St-Denis, Universite de Sherbrooke, 2005.
*/

        .section ".text"
main:
        setx    ptfmt1,%l7,%o0 ! 1er parametre : adresse de la chaine a imprimer
        call    printf         ! impression de la requete des donnees
        nop

        setx    scfmt1,%l7,%o0 ! 1er parametre : adresse du format d'entree
        setx    ch,%l7,%o1     ! 2e parametre : adresse de la chaine
        call    scanf          ! lecture de la chaine de caracteres
        nop

        setx    ch,%l7,%l0
        ldx     [%l0],%o0
        setx    cle,%l7,%l0
        ldx     [%l0],%o1
        setx    tampon,%l7,%o2
        call    DES            ! encoder la chaine de 64 bits
        nop

        setx    chc,%l7,%l0
        stx     %o0,[%l0]

        setx    ch,%l7,%o1     ! 2e parametre : l'adresse de la chaine
        mov     %o0,%o2        ! 3e parametre : valeur binaire de 64 bits
        setx    ptfmt2,%l7,%o0 ! 1er parametre : adresse de la chaine a imprimer
        call    printf         ! impression de la chaine encodee
        nop

        setx    chc,%l7,%l0
        ldx     [%l0],%o0
        setx    cle,%l7,%l0
        ldx     [%l0],%o1
        setx    tampon,%l7,%o2
        call    DESinv         ! decoder la chaine de 64 bits
        nop

        setx    chd,%l7,%l0
        stx     %o0,[%l0]

        mov     %l0,%o1        ! 2e parametre : l'adresse de la chaine
        mov     %o0,%o2        ! 3e parametre : valeur binaire de 64 bits
        setx    ptfmt3,%l7,%o0 ! 1er parametre : adresse de la chaine a imprimer
        call    printf         ! impression de la chaine decodee
        nop

        clr     %o0            ! 1er parametre
        call    fflush         ! vidange des tampons de fichiers
        nop

        clr     %o0            ! 1er parametre
        call    exit           ! sortie du programme
        nop

/* Definition des donnees */

        .section ".bss"
        .align  8
ch:     .skip   8
        .byte   0
        .align  8
tampon: .skip   256

        .section ".data"
        .align  8
chc:    .skip   8
        .byte   0
        .align  8
chd:    .skip   8
        .byte   0

        .section ".rodata"
scfmt1: .asciz  "%llx"
ptfmt1: .asciz  "Entrez une chaine de caracteres (nombre hexadecimal de 16 chiffres).\n"
ptfmt2: .asciz  "La chaine encodee est de %s  est %llx.\n"
ptfmt3: .asciz  "La chaine decodee est : %s (%llx).\n"

        .align  8
cle:    .xword  0x0123456789ABCDEF
