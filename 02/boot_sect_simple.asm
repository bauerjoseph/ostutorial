mov ah, 0x0e ; tty modeAa
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

jmp $ ; This jumps to the current address

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; The mgic boot number
dw 0xaa55
