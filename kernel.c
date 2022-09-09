#include<stdbool.h>
#include<stdint.h>
#include<stddef.h>

// DRIVER: VGA
void WriteCharacter(unsigned char c, unsigned char forecolour, unsigned char backcolour, int x, int y)
{
     uint16_t attrib = (backcolour << 4) | (forecolour & 0x0F);
     volatile uint16_t * where;
     where = (volatile uint16_t *)0xB8000 + (y * 80 + x) ;
     *where = c | (attrib << 8);
}

void write_string(int colour, const char *string, unsigned char backcolour, int x, int y, int numero_caratteri)
{
    volatile char *video = (volatile char*)0xB8000;         // VGA
    uint16_t attrib = (backcolour << 4) | (colour & 0x0f);  //set background and text color
    volatile uint16_t * where;
    int i = 0;                          // counter
    while (i < numero_caratteri)                // algorithm that takes every character of the list and prints it
    {
        where = (volatile uint16_t *) 0xB8000 + (y * 80 + x + i);
        *where = *string++ | (attrib << 8);
        i++;
    }
}

// kernel
_main()
{
    const char cubix[5] = {'C', 'u', 'b', 'i', 'x'};
    write_string(0x0f, cubix, 0x00, 0, 0, 5);
    const char txt[15] = {'R', 'e', 'm', 'o', 'v', 'e', 'd', ' ', 'v', 'e', 'r', 's', 'i', 'o', 'n'};
    write_string(0x0f, txt, 0x00, 0, 1, 15);
}
// TEMPORARY VERSION
