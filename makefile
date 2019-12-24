CPP = g++

TARGET = demo.x86

OBJS = obj/Canvas.o\
       obj/CoordPair.o\
       obj/CoordTriple.o\
       obj/Perspective.o

SDL2 = -D_REENTRANT -I/usr/include/SDL2 -lSDL2

SRC = src/Canvas.cpp\
      src/Canvas.hpp\
      src/CoordPair.cpp\
      src/CoordPair.hpp\
      src/CoordTriple.cpp\
      src/CoordTriple.hpp\
      src/Perspective.cpp\
      src/Perspective.hpp\
      demo/main.cpp

FLAGS = -O3 -Wall -lm -std=c++11

GPROF_FLAGS = -O3 -pg -Wall -lm -std=c++11

ASM_FLAGS = -S\
	    -masm=intel\
	    -fno-asynchronous-unwind-tables\
	    -fno-dwarf2-cfi-asm\
	    -O3\
	    -Wall\
	    -std=c++11

ASM_FILES = asm/CoordPair.asm\
	    asm/CoordTriple.asm\
	    asm/Perspective.asm\
	    asm/Canvas.asm\
	    asm/demo_main.asm

$(TARGET): $(SRC)
	$(CPP) $(FLAGS) -c src/CoordPair.cpp -o obj/CoordPair.o
	$(CPP) $(FLAGS) -c src/Perspective.cpp -o obj/Perspective.o
	$(CPP) $(FLAGS) -c src/Canvas.cpp -o obj/Canvas.o
	$(CPP) $(FLAGS) -c src/CoordTriple.cpp -o obj/CoordTriple.o
	$(CPP) $(FLAGS) $(OBJS) demo/main.cpp -o $(TARGET) $(SDL2)

prof: $(SRC)
	$(CPP) $(GPROF_FLAGS) -c src/CoordPair.cpp -o obj/CoordPair.o
	$(CPP) $(GPROF_FLAGS) -c src/Perspective.cpp -o obj/Perspective.o
	$(CPP) $(GPROF_FLAGS) -c src/Canvas.cpp -o obj/Canvas.o
	$(CPP) $(GPROF_FLAGS) -c src/CoordTriple.cpp -o obj/CoordTriple.o
	$(CPP) $(GPROF_FLAGS) $(OBJS) demo/main.cpp -o $(TARGET) $(SDL2)
	./$(TARGET)
	gprof $(TARGET) gmon.out > profile.txt

$(ASM_FILES): $(SRC)
	$(CPP) $(ASM_FLAGS) -c src/CoordPair.cpp -o asm/CoordPair.tmp;
	cat asm/CoordPair.tmp | c++filt > asm/CoordPair.asm;
	rm asm/CoordPair.tmp
	$(CPP) $(ASM_FLAGS) -c src/Perspective.cpp -o asm/Perspective.tmp;
	cat asm/Perspective.tmp | c++filt > asm/Perspective.asm;
	rm asm/Perspective.tmp
	$(CPP) $(ASM_FLAGS) -c src/Canvas.cpp -o asm/Canvas.tmp;
	cat asm/Canvas.tmp | c++filt > asm/Canvas.asm;
	rm asm/Canvas.tmp
	$(CPP) $(ASM_FLAGS) -c src/CoordTriple.cpp -o asm/CoordTriple.tmp;
	cat asm/CoordTriple.tmp | c++filt > asm/CoordTriple.asm;
	rm asm/CoordTriple.tmp
	$(CPP) $(ASM_FLAGS) demo/main.cpp -o asm/demo_main.tmp;
	cat asm/demo_main.tmp | c++filt > asm/demo_main.asm;
	rm asm/demo_main.tmp

asm: $(ASM_FILES)

run: $(TARGET)
	./$(TARGET)

clean: $(TARGET) $(OBJS)
	rm $(TARGET)
	rm $(OBJS)

clean-asm: $(ASM_FILES)
	rm asm/*.asm
