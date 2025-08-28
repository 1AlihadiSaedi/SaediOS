#include "log.h"
#include "color.h"

#define MULTIBOOT_MAGIC 0x1BADB002
#define MULTIBOOT_PAGE_ALIGN (1 << 0)
#define MULTIBOOT_PAGE_INFO (1 << 0)
#define MULTIBOOT_FLAGS (MULTIBOOT_PAGE_ALIGN | MULTIBOOT_PAGE_INFO)

//Mutiboot Header
const struct MultibootHeader {
    unsigned int magic;
    unsigned int flags;
    unsigned int checksum;

}   multiboot_header = {

    .magic = MULTIBOOT_MAGIC,
    .flags = MULTIBOOT_FLAGS,
    .checksum = -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)
};


void kernel_main()
{
    color ColorText = ABlue();
    
    log("Welcome to SaediOS!",0,Black(),ColorText);

    for(;;);
}