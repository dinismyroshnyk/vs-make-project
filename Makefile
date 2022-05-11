#defines the compiler to be used
CC = gcc

#defines the compile-time flags to be used
CFLAGS = -Wall -Wextra -g

#---------------------------------------------------------------------------------------------------------------------

#definig the directories to be used
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

INCLUDES	:= $(patsubst %,-I%, $(INCLUDEDIRS:%/=%))
SOURCES		:= $(wildcard $(addsuffix /*.c, $(SOURCEDIR))) #----------FIXME - may be broken
OBJECTS		:= $($(SOURCES):%.c=$(TEMPDIR)/%.o) #----------FIXME - may be broken
APPFILE	:= $(call FIXPATH,$(APP)/$(APPNAME))

#---------------------------------------------------------------------------------------------------------------------

#DO NOT EDIT ANYTHING BELOW THIS LINE
all:compile build run

compile:
	@echo "Compiling..."
	gcc -c  src/teste.c -I include/ -o temp/teste.o
	gcc -c  src/main.c -I include/ -o temp/main.o

build:
	@echo "Building..."
	gcc temp/*.o -I include/ -o app/app

run:
	./$(APPFILE)
	@echo "All done!"

clean:
	$(RM) ./temp/*.o
	$(RM) ./app/*
	@echo "All cleaned"
