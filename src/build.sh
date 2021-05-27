mkdir -p ../game &&
output="../game" &&
rgbasm -E -o $output/main.o main.asm &&
  rgblink -o $output/metronome.gb $output/main.o -n $output/metronome.sym &&
  rgbfix -v -p 255 $output/metronome.gb && rm $output/*.o
