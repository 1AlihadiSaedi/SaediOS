#define MULTIBOOT_MAGIC 0x1BADB002
#define MULTIBOOT_PAGE_ALIGN (1 << 0)
#define MULTIBOOT_PAGE_INFO (1 << 0)
#define MULTIBOOT_FLAGS (MULTIBOOT_PAGE_ALIGN | MULTIBOOT_PAGE_INFO)

//Mutiboot Header
__attribute__((section(".multiboot")))
const struct MultibootHeader {
    unsigned int magic;
    unsigned int flags;
    unsigned int checksum;

}   multiboot_header = {

    .magic = MULTIBOOT_MAGIC,
    .flags = MULTIBOOT_FLAGS,
    .checksum = -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)
};


void main()
{
    char* video_memory = (char*) 0xb8000;

    video_memory[0] = 'H';
    video_memory[1] = 0x07;

    video_memory[2] = 'I';
    video_memory[3] = 0x07;

    while (1);
}
