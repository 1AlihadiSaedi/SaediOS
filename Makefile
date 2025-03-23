kernel := kernel.c
output := kernel.bin 
obj := kernel.o
linker := linker.ld
grub := grub.cfg
Saedi := SaediOS.iso
ckernel:
	@gcc -c $(kernel) -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -fno-exceptions
	@echo Compiled $(kernel)!

linker:
	ld -n -o $(output) -T $(linker) $(obj) 
	
makeing-iso:
	@mkdir -p iso/boot/grub
	@cp $(grub) iso/boot/grub
	@cp $(output) iso/boot/
	@grub-mkrescue -o $(Saedi) iso
	@rm -r iso
	@echo Export $(Saedi)!

qemu:
	qemu-system-x86_64 -cdrom $(Saedi)

rm-all:
	@rm -f $(obj) $(output)
	@echo delete All!
	
	
rm-all-iso:
	@make rm-all
	@rm $(Saedi)
	
export-all:
	@make ckernel
	@make linker
	@make makeing-iso
	
export-all-rm:
	@make export-all
	@make rm-all
	
export-all-qemu:
	@make export-all
	@make qemu
	
export-all-qemu-rm:
	@make export-all-rm
	@make qemu
	

install-apt:
	sudo apt update
	sudo apt install -y \
    build-essential \
    gcc-multilib \
    grub-pc-bin \
    xorriso \
    qemu-system-x86 \
    nasm \
    binutils
	
install-pacman:
	sudo pacman -Syu
	sudo pacman -S --needed \
    base-devel \
    gcc \
    grub \
    qemu \
    qemu-arch-extra \
    nasm \
    binutils \
    xorriso \
    gdb \
    dosfstools \
    mtools
