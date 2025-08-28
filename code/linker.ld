ENTRY(kernel_main)

SECTIONS {
    . = 1M;

    .text ALIGN(2K):{
        *(.text)
    }

    .data ALIGN(2K):{
        *(.data)
    }

    .bss ALIGN(2K):{
        *(.bss)
    }
}
