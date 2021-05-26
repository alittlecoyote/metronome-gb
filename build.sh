rgbasm -E -o game/main.o main.asm && rgblink -o game/metronome.gb game/main.o -n game/metronome.sym && rgbfix -v -p 255 game/metronome.gb && rm game/*.o
