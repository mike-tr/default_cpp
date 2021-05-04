#pragma once
#include <iostream>

using namespace std;
void pPrintShape(void *ptr);

class Shape {
protected:
    int x, y;
    void (*printFp)(void *);

public:
    Shape() : Shape(0, 0) {}

    Shape(int x, int y) {
        this->x = x;
        this->y = y;
        printFp = &pPrintShape;
    }

    void print() {
        printFp(this);
    }

    friend void pPrintShape(void *);
};

void pPrintShape(void *ptr) {
    Shape &shape = *((Shape *)ptr);
    cout << "Shape : " << shape.x << " ," << shape.y << endl;
}

class Sphere : public Shape {
private:
    double radius;

public:
    Sphere() : Sphere(0, 0, 1) {
        //printFp = &pPrintShape;
        printFp = &printSphere;
    }

    Sphere(int x, int y, double r) : Shape(x, y) {
        this->radius = r;
    }

    static void printSphere(void *ptr) {
        Sphere &self = *((Sphere *)ptr);
        cout << "Sphere, Center : ( " << self.x << " ," << self.y << " ), radius : " << self.radius << endl;
    }
};