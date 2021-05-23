rgbasm -o main.o main.asm;
rgblink -o metronome.gb main.o;
rgbfix -v -p 0 metronome.gb;
rm *.o
