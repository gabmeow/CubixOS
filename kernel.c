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

// DRIVER: keyboard
int curMode;

uint8_t inb(uint16_t port)
{
    uint8_t ret;
    asm ("inb %%dx,%%al":"=a" (ret):"d" (port));
    return ret;
}

void outb(uint16_t port,uint8_t value)
{
   asm("outb %%al,%%dx": :"d" (port), "a" (value));
}

const char kbdus[128] =
{
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8',	/* 9 */
  '9', '0', '-', '=', '\b',	/* Backspace */
  '\t',			/* Tab */
  'q', 'w', 'e', 'r',	/* 19 */
  't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',	/* Enter key */
    0,			/* 29   - Control */
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',	/* 39 */
 '\'', '`',   0,		/* Left shift */
 '\\', 'z', 'x', 'c', 'v', 'b', 'n',			/* 49 */
  'm', ',', '.', '/',   0,				/* Right shift */
  '*',
    0,	/* Alt */
  ' ',	/* Space bar */
    0,	/* Caps lock */
    0,	/* 59 - F1 key ... > */
    0,   0,   0,   0,   0,   0,   0,   0,
    0,	/* < ... F10 */
    0,	/* 69 - Num lock*/
    0,	/* Scroll Lock */
    0,	/* Home key */
    0,	/* Up Arrow */
    0,	/* Page Up */
  '-',
    0,	/* Left Arrow */
    0,
    0,	/* Right Arrow */
  '+',
    0,	/* 79 - End key*/
    0,	/* Down Arrow */
    0,	/* Page Down */
    0,	/* Insert Key */
    0,	/* Delete Key */
    0,   0,   0,
    0,	/* F11 Key */
    0,	/* F12 Key */
    0,	/* All other keys are undefined */
};

int shift_pressed = false;
int caps_lock = false;

void keyboard_handler()
{
    uint8_t scancode;

    outb(0x20, 0x20);

    scancode = inb(0x60);

    if ((scancode & 0x80) == 0x80)
    {
        switch (scancode)
        {
        case 0xAA:
            shift_pressed = false;
            break;
        
        default:
            break;
        }
    }

    else
    {
        switch (scancode)
        {
        case 0x2A:
            shift_pressed = true;
            break;
        
        case 0x3A:
            caps_lock = !caps_lock;
            break;
        
        default:
            break;
        }
    }
    
    
}

// kernel
_main()
{
    //int abc = 1;
    keyboard_handler();
    const char error[5] = {'E', 'R', 'R', 'O', 'R'};  
    const char cubix[5] = {'C', 'u', 'b', 'i', 'x'};
    write_string(0x0f, cubix, 0x00, 0, 0, 5);
    const char version[6] = {'V', '0', '0', '1', 'A', '5'};
    write_string(0x0f, version, 0x00, 0, 1, 6);
    const char test[4] = {'T', 'e', 's', 't'}; 
}
