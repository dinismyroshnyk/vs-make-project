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
APPDIR	:= $(APP)
FIXPATH	= $(subst /,\,$1)
REMOVE	:= del /q /f
MAKEDIR	:= mkdir
else
APPNAME	:= app
SOURCEDIR	:= $(shell find $(SRC) -type d)
INCLUDEDIR	:= $(shell find $(INCLUDE) -type d)
TEMPDIR	:= $(shell find $(TEMP) -type d)
APPDIR	:= $(shell find $(APP) -type d)
FIXPATH = $1
REMOVE = rm -f
MAKEDIR	:= mkdir -p
endif

#---------------------------------------------------------------------------------------------------------------------

SOURCES		:= $(wildcard $(addsuffix /*.c, $(SOURCEDIR))) #----------FIXME - may be broken
OBJECTS		:= $($(SOURCES):%.c=$(TEMPDIR)/%.o) #----------FIXME - may be broken
APPFILE	:= $(call FIXPATH,$(APPDIR)/$(APPNAME))

#---------------------------------------------------------------------------------------------------------------------

#DO NOT EDIT ANYTHING BELOW THIS LINE
all:compile build run

compile:
	@echo "Compiling..."
	$(CC) $(CFLAGS) -c  $(SOURCEDIR)/teste.c -I $(INCLUDEDIR)/ -o $(TEMPDIR)/teste.o
	$(CC) $(CFLAGS) -c  $(SOURCEDIR)/main.c -I $(INCLUDEDIR)/ -o $(TEMPDIR)/main.o

build:
	@echo "Building..."
	$(CC) $(CFLAGS) $(TEMPDIR)/*.o -I $(INCLUDEDIR)/ -o $(APPDIR)/app

run:
	./$(APPFILE)
	@echo "All done!"

clean:
	$(REMOVE) ./temp/*.o
	$(REMOVE) ./app/*
	@echo "All cleaned"
