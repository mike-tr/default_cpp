# credit https://stackoverflow.com/questions/40621451/makefile-automatically-compile-all-c-files-keeping-o-files-in-separate-folde

# made by michael trushkin
# this makefile compiles all cpp files and create an main object.

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

HEADERS := $(wildcard $(HPP_PATH)*.hpp)
SOURCES := $(wildcard $(SRC_PATH)*.cpp)
OBJECTS := $(patsubst $(SRC_PATH)%.cpp, $(OBJ_PATH)%.o, $(SOURCES))

run: $(EXE_PATH)$(PROG_NAME)
	./$^

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