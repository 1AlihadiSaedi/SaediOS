#include "stdint.h"

#ifndef LOG_H
#define LOG_H

int green () { return 0x2; }


int sizein (const char* value)
{
    int size = 0;

    for(int i = 0; value[i] != '\0'; i++)
    {
        if (value[i] > 0) size++;
    }

    return size;
}

int log (const char* text, const int map,const int Background_color, const uint32_t Text_color)
{
    unsigned char* video_memory = (unsigned char*) 0xb8000;

    int i = 0;

    int size = sizein(text);

    while (size > 0)
    {
        video_memory[map*2 + i * 2] = text[i];
        video_memory[map*2  + i * 2 + 1] = Background_color * 16 + Text_color;
        
        i++;
        size--;
    }

    return (i + map);
}


#endif
