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

APPFILE	:= $(call FIXPATH,$(APPDIR)/$(APPNAME))

#---------------------------------------------------------------------------------------------------------------------

#DO NOT EDIT ANYTHING BELOW THIS LINE
all:compile build run

compile:$(TEMPDIR)/main.o $(TEMPDIR)/teste.o $(TEMPDIR)/abc.o 

build:
	$(CC) $(CFLAGS) $(TEMPDIR)/*.o -I $(INCLUDEDIR) -o $(APPFILE)

$(TEMPDIR)/%.o:$(SOURCEDIR)/%.c $(INCLUDEDIR)/*.h
	$(CC) $(CFLAGS) -c $< -I $(INCLUDEDIR) -o $@

run:
	./$(APPFILE)
	@echo "All done!"

clean:
	$(REMOVE) ./temp/*.o
	$(REMOVE) ./app/*
	@echo "All cleaned"
