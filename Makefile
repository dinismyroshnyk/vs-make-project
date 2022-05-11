#defines the compiler to be used
CC = gcc

#defines the compile-time flags to be used
CFLAGS = -Wall -Wextra -g

#---------------------------------------------------------------------------------------------------------------------

#definig the directiries to be used
APP	:= app
INCLUDE	:= include
SRC	:= src
TEMP := temp

#---------------------------------------------------------------------------------------------------------------------

#defining OS specific commands 
ifeq ($(OS),Windows_NT)
APPNAME	:= app.exe
SOURCEDIR	:= $(SRC)
INCLUDEDIR	:= $(INCLUDE)
TEMPDIR	:= $(TEMP)
FIXPATH	= $(subst /,\,$1)
REMOVE	:= del /q /f
MAKEDIR	:= mkdir
else
APPNAME	:= app
SOURCEDIR	:= $(shell find $(SRC) -type d)
INCLUDEDIR	:= $(shell find $(INCLUDE) -type d)
TEMPDIR	:= $(shell find $(TEMP) -type d)
FIXPATH = $1
REMOVE = rm -f
MAKEDIR	:= mkdir -p
endif

#---------------------------------------------------------------------------------------------------------------------

#defiing source and object files
SOURCES		:= $(wildcard $(patsubst %,%/*.c, $(SOURCEDIR)))
OBJECTS		:= $(patsubst %,$(TEMPDIR)/%,$(SOURCEDIR))

#---------------------------------------------------------------------------------------------------------------------

#DO NOT EDIT ANYTHING BELOW THIS LINE
all:
	@echo "Building..."

run: all
	./app
	@echo "Done!"

clean:
	$(RM) ./temp/*.o
	$(RM) ./app/*
	@echo "All cleaned"
