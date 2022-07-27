void write_string( int colour, const char *string )
{
    volatile char *video = (volatile char*)0xB8000;
    while( *string != 0 )
    {
        *video++ = *string++;
        *video++ = colour;
    }
}

_main()
{
    const char string[5] = {'H', 'e', 'l', 'l', 'o'};
    write_string(0x0f, string);
}
