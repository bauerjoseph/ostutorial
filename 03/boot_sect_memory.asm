mov ah, 0x0e

; First attempt 
; Doesn't work because it tries to print the memory address instead
; of the contents
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; Second attempt 
; This also tries to print the memory address of secret, which is good
; However, this doesn't work. The BIOS places our bootsector binary at address 0x7c00
; The next attempt will show that.
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; add the BIOS starting offset 0x7c00 to the memory address of the X
; and dereferences the contents of that pointer
; Why 0x7c00?...  This is because, when a boot loader takes control, it loads all 512 bytes of 
; The bootloader to that address
; We need another register beacuse al connot be the source and destination for the same command
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
; Shortcut. Since we know where X is stored, we can just print that address
; HOWEVER, not good idea, not always consistent

mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ; Infinite loop

the_secret:
    ; ASCII code 0x58('X') is stored just before all of the zero padding
    ; In this example, that is at byte 0x2d
    ; you can check this out with 'xxd file.bin'
    db "X"

; Zero padding and magic number!
times 510-($-$$) db 0
dw 0xaa55
