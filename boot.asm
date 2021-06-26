[bits 16]			; Set NASM to use 16 bit instructions (thats whats used at boot by BIOS)
[org 0x7c00]			; Tell BIOS to load bootloader at 0x7c00 in memory

; The main instruction for the bootloader
boot:
	mov	si,	message	; Load the address of the first character into the pointer
	call	print_string	; Call the function to print the string
	jmp	halt		; Halt once the main function is done

; Function for printing strings
print_string:
	mov	ah,	0x0e	; Makes the BIOS print a character to the cursor
.loop:
	lodsb			; Load a character from the string and increment the character pointer
	or	al,	al	; Or the same register to get flags like 'zero', faster than cmp
	jz	.done		; If the character is null (end of the string), return
	int	10h		; Call the video services BIOS interupt
	jmp	.loop		; Go back to the start of the loop
.done:
	ret			; Return once the string is finished printing

; Function for once there is nothing else to do
halt:
	cli			; Disable interupts (honestly not sure why to do this)
	hlt			; Stop the CPU from executng code

; The message we want to print to the screen
message:	db	"Hello!"

times	510 - ($ - $$)	db 0	; Pad the rest of the image untill the magic number with zeros
dw	0xaa55			; The magic boot number (tells the BIOS to boot this sector)
