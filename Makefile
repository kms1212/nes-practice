CC=cc65
CFLAGS=-t nes -Iinc

AS=ca65
ASFLAGS=-t nes -Iinc

LD=ld65
LDFLAGS=-t nes

BINDIR=build
TARGET=rom.nes
OBJECTS=data.o init.o main.o object.o joy.o bg.o

vpath %.S src

.PHONY: all clean run

all: $(TARGET)

clean:
	rm -rf $(TARGET) $(OBJECTS)

run: $(TARGET)
	fceux $<

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@ 

%.o: %.S
	$(AS) $(ASFLAGS) $< -o $@

