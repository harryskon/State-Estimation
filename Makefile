#----------------------------------------------------#
#--Author: Harrys Kon (Charalambos Konstantinou)-----#
#--W: https://harrys.fyi/----------------------------#
#--E: konharrys@gmail.com----------------------------#
#----------------------------------------------------#
#CPP = g++
DEBUG = -g
CPP_ANSI_OPTS = -std=c++14
PTHREAD=-pthread
RM=rm -f
MODBUS = `pkg-config --libs --cflags libmodbus`
MODBUS1 = -I/usr/include/modbus/ -L/usr/local/lib -lmodbus
LDFLAGS=$(PTHREAD)
CPPFLAGS = -Wall $(DEBUG) $(CPP_ANSI_OPTS)
LDLIBS = -L/usr/local/lib -lmodbus
INC = -I/usr/include/modbus/
SRC_DIR = src

ifeq "$(shell expr `g++ -dumpversion | cut -f1 -d.` \> 4.9)" "1"
	CPP = g++
else ifeq "$(shell expr `g++-4.9 -dumpversion | cut -c 1-3` \= 4.9)" "1"
	CPP = g++-4.9
else
	$(error Please install gcc/g++ 4.9 or greater)
endif


SOURCES= $(wildcard $(SRC_DIR)/*.cpp)
EXECUTABLE=estimation
    
$(EXECUTABLE): 
	$(CPP) $(CPPFLAGS) $(LDFLAGS) $(SOURCES) -o $@ $(MODBUS)

.PHONY : $(EXECUTABLE) clean

clean :
	$(RM) $(EXECUTABLE)
