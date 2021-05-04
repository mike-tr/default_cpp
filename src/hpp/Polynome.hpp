#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

typedef unsigned int uint;

class Polynome {
private:
    std::vector<double> xi;
    int size = 0;

public:
    Polynome() {}

    double &operator[](uint index);
    double operator()(double x);
};
