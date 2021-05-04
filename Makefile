# credit https://stackoverflow.com/questions/40621451/makefile-automatically-compile-all-c-files-keeping-o-files-in-separate-folde

# made by michael trushkin
# this makefile compiles all cpp files and create an main object.
# the files assume that everything is dependent so it might have bigger compile time.
# but it easier then adding by hand.

# note : this setup supports only 1 main file.

CXX=clang++-9 
CXXFLAGS=-std=c++2a -Werror -Wsign-conversion
VALGRIND_FLAGS=-v --leak-check=full --show-leak-kinds=all  --error-exitcode=99

# name of the executable file
PROG_NAME := pragma.exe

# set the path of the executable file
EXE_PATH := out/

SRC_PATH := src/
OBJ_PATH := obj/
HPP_PATH := src/hpp/

# get all the .hpp files that are inside the HPP folder.
HEADERS := $(wildcard $(HPP_PATH)*.hpp)

# get all the .cpp files that are inside the SRC_PATH folder.
SOURCES := $(wildcard $(SRC_PATH)*.cpp)

# name of all .o files that needs to be created
# how it works
# assume SRC_PATH = "src/"
# OBJ_PATH = "obj/"
# SOURCES = src/f1.cpp src/f2.cpp
# get from $(SOURCES) all the names.
# find the sequence src/%.cpp in our case it would be f1, f2
# add to % the format obj/%.o so we get
# obj/f1.o obj/f2.o
# now OBJECTS = obj/f1.o obj/f2.o
# now we can use OBJECTS to compile all the needed files.
OBJECTS := $(patsubst $(SRC_PATH)%.cpp, $(OBJ_PATH)%.o, $(SOURCES)) 

#compile and run the exe
run: $(EXE_PATH)$(PROG_NAME)
	./$^

#Compile all the .o files.
all: $(OBJECTS)

# Compline everything, and create an executable file
# Note there is no need to specify where is the main function.
# Note will crash if there is multiple main functions!
$(EXE_PATH)$(PROG_NAME) : $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $(EXE_PATH)$(PROG_NAME)

# main: main.o $(OBJECTS)
# 	$(CXX) $(CXXFLAGS) $(OBJECTS) -o main

$(OBJ_PATH)%.o: $(SRC_PATH)%.cpp $(HEADERS)
	$(CXX) $(CXXFLAGS) --compile $< -o $@

tidy:
	clang-tidy $(SOURCES) -checks=bugprone-*,clang-analyzer-*,cppcoreguidelines-*,performance-*,portability-*,readability-*,-cppcoreguidelines-pro-bounds-pointer-arithmetic,-cppcoreguidelines-owning-memory --warnings-as-errors=-* --

valgrind: test
	valgrind --leak-check=full --error-exitcode=99 --tool=memcheck $(VALGRIND_FLAGS) ./test 

clean:
	rm -f $(OBJ_PATH)*.o $(OBJECTS) $(EXE_PATH)$(PROG_NAME) *.o main