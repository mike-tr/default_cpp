#include "hpp/Polynome.hpp"

double &Polynome::operator[](uint index) {
    while (xi.size() <= index) {
        xi.push_back(0);
    }
    return xi.at(index);
}

double Polynome::operator()(double x) {
    double val = 0;
    for (uint i = 0; i < xi.size(); i++) {
        double v = (*this)[i];
        for (int j = 0; j < i; j++) {
            v *= x;
        }
        val += v;
    }
    return val;
}