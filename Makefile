kernel := kernel.c
output := kernel.bin 
obj := kernel.o
linker := linker.ld
grub := grub.cfg
Saedi := SaediOS.iso
dir := code/
export := export/

ckernel:
	@gcc -m32 -c $(dir)$(kernel) -o kernel.o -ffreestanding -O2 -Wall -Wextra
	@cp $(obj) $(export)
	@rm $(obj)
	@echo Compiled $(kernel)!
	

linker:
	@ld -m elf_i386 -nostdlib -T $(dir)$(linker) -o $(output) $(export)$(obj) 
	@cp $(output) $(export)
	@rm $(output)
	@echo exported kernel.bin! 
	
makeing-iso:
	@mkdir -p iso/boot/grub
	@cp $(dir)$(grub) iso/boot/grub
	@cp $(export)$(output) iso/boot/
	@grub-mkrescue -o $(Saedi) iso
	@cp $(Saedi) $(export)
	@rm $(Saedi)
	@rm -r iso
	@echo Export $(Saedi)!

qemu:
	qemu-system-x86_64 -cdrom $(export)$(Saedi)

rm-all:
	@rm -f $(export)$(obj) $(export)$(output)
	@echo delete All!
	
	
rm-all-iso:
	@make rm-all
	@rm $(export)$(Saedi)
	
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
	sudo pacman -Sy
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


#NEW
#sudo apt-get install gcc-multilib g++-multilib 
