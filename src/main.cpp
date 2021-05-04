#include "hpp/Polynome.hpp"
#include "hpp/Shape.hpp"

int main() {
    Shape *shapes[5];
    for (int i = 0; i < 5; i++) {
        if (i % 2 == 0) {
            shapes[i] = new Sphere(1, i, 3.14);
        } else {
            shapes[i] = new Shape(0, 5);
        }
    }

    for (int i = 0; i < 5; i++) {
        shapes[i]->print();
    }

    Polynome p;
    p[0] = -1;
    p[1] = -2;
    p[2] = 4;

    // p = 4x^2-2x-1

    cout << p(0) << endl; // -1
    cout << p(1) << endl; // 1
    cout << p(2) << endl; // 11
    return 0;
}