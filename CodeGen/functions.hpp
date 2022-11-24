#ifndef CONIC_H
#define CONIC_H

// #include <bits/stdc++.h>
#include <iostream>
#include <cmath>
#include <map>
#include <string>

// if(!NULL) checking

using namespace std;
double pi = 2 * acos(0.0);

map<string, class Conic *> conic_ids;
map<string, class Point*> points;

class Conic;
class Line;
class Line_pair;
class Parabola;
class Ellipse;
class Hyperbola;
class circle;

class Point
{
public:
    double x;
    double y;
    Point(double _x, double _y);
    Point(int _x, int _y);
};


Point::Point(double _x, double _y)
{
    x = _x;
    y = _y;
};

Point::Point(int _x, int _y)
{
    x = _x;
    y = _y;
};


class Conic
{
public:
    double a;
    double b;
    double h;
    double c;
    double g;
    double f;
    Conic(double _a, double _h, double _b, double _g, double _f, double _c);
    string eq_();
    Line* tangent(Point* p);
    Line* normal(Point* p);
    Point* center();
    bool on_curve(Point* p1);
    double delta();
    double eccen();
    string conic_name();
    Conic* p_axis();
    double latus_rectum();
    Conic* directrix();
    Point* vertex();
    Point* focii();
};

class Line : public Conic
{
public:
    Line(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _f, _c) {}
    double slope();

};

// Line* function_temp(double a, double h, double b, double g, double f, double c){
//     Parabola* p = new Parabola(this->a, this->h, this->b, this->g, this->f, this->c);
//     Line* l = p.p_axis();
//     return l;
// };


Line* function_temp(double,double,double,double,double,double);

class Line_pair : public Conic
{
public:
    Line_pair(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _f, _c){}
};

class Circle : public Conic
{
public:
    Circle(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _f, _c) {}

    double radius();
    double circumf();
    double area_cir();
    Point* focii();
};

class Parabola : public Conic
{
public:
    Parabola(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _f, _c){};
    double focal_chord(Point* p);
    Line* directrix();
    Line* p_axis();
    double latus_rectum();
    Point* vertex();
    Point* focii();
};

class Ellipse : public Conic
{
public:
    Ellipse(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _f, _c) {}
    double len_maj_axis();
    double len_min_axis();
    double latus_rectum();
    Circle* dir_circle();
    Circle* aux_circle();
    double circumf();
    double area();
    Line* directrix();
    Line* p_axis();
    Point* vertex();
    Point* focus();
};

class Hyperbola : public Conic
{
public:
    Hyperbola(double _a, double _h, double _b, double _g, double _f, double _c) : Conic(_a, _h, _b, _g, _h, _c) {}
    Line* trans_axis();
    Line* conj_axis();
    Circle* dir_circle();
    Circle* aux_circle();
    Line_pair* asymptotes();
    Line* directrix();
    double latus_rectum();
    Line* p_axis();
    Point* vertex();
    Point* focus();
};


Conic::Conic(double _a, double _h, double _b, double _g, double _f, double _c)
{
    a = _a;
    h = _h;
    b = _b;
    g = _g;
    f = _f;
    c = _c;
}

string Conic::eq_()
{
    string s1 = "";
    string s2 = "";
    string s3 = "";
    string s4 = "";
    string s5 = "";
    if (b >= 0)
    {
        s1 = "+";
    }
    if (h >= 0)
    {
        s2 = "+";
    }
    if (g >= 0)
    {
        s3 = "+";
    }
    if (f >= 0)
    {
        s4 = "+";
    }
    if (c >= 0)
    {
        s5 = "+";
    }
    string s = to_string(a) + "x^2" + s1 + to_string(b) + "y^2" + s2 + to_string((2 * h)) + "xy" + s3 + to_string((2 * g)) + "x" + s4 + to_string((2 * f)) + "y" + s5 + to_string(c);
    return s;
}

Line* Conic::tangent(Point* p)
{
    double c2;
    double x_ = p->x;
    double y_ = p->y;
    if ((b * y_ + h * x_ + f) == 0)
    {
        c2 = x_;
        Line* l1 = new Line(0, 0, 0, -1, 0, c2);
        return l1;
    }
    double m = -(a * x_ + h * y_ + g) / (b * y_ + h * x_ + f);
    c2 = y_ - m * x_;
    Line* l1 = new Line(0, 0, 0, m, -1, c2);
    return l1;
}

Line* Conic::normal(Point* p)
{
    double c2;
    Line* l1;
    double x_ = p->x;
    double y_ = p->y;
    if ((a * x_ + h * y_ + g) == 0)
    {
        c2 = x_;
        l1 = new Line(0, 0, 0, -1, 0, c2);
        return l1;
    }
    double m = (b * y_ + h * x_ + f) / (a * x_ + h * y_ + g);
    c2 = y_ - m * x_;
    l1 = new Line(0, 0, 0, m, -1, c2);
    return l1;
}

Point* Conic::center()
{
    double x = ((f * h - b * g) / (a * b - h * h));
    double y = ((g * h - a * f) / (a * b - h * h));
    Point* temp = new Point(x, y);
    return temp;
}

bool Conic::on_curve(Point* p1)
{
    int x = p1->x;
    int y = p1->y;
    double temp = a * x * x + 2 * h * x * y + b * y * y + 2 * g * x + 2 * f * y + c;
    if (temp == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

double Conic::delta()
{
    double temp = (a * b * c + 2 * f * g * h - a * f * f - b * g * g - c * h * h);
    return temp;
}

double Conic::eccen()
{
    double p = 2 * h;
    double d = 2 * g;
    double e = 2 * f;
    double temp;
    double m = sqrt((a - b) * (a - b) + p * p);
    double n = f * (p * p - 4 * a * b) + a * e * e - p * d * e + b * d * d;
    if (n > 1)
    {
        temp = 2*m / (m + a + b);
    }
    else if (n < 1)
    {
        temp = 2*m / (m - a - b);
    }
    else
    {
        cout << "Invalid call to eccentricity function\n";
        return 0.0;
    }
    return temp;
}

string Conic::conic_name()
{
    double d = (a * b * c + 2 * f * g * h - a * f * f - b * g * g - c * h * h);
    string ret;
    if (d == 0)
    {
        if (h == 0 && a * b > 0)
        {
            ret = "Point";
        }
        if (h * h == a * b && g * f == h * c)
        {
            ret = "Line";
        }
        else if ((a * b - h * h) <= 0)
        {
            ret = "Pair of lines";
        }
    }
    else
    {
        double tmp = (h * h) - (a * b);
        if (h == 0 && a == b)
        {
            ret = "Circle";
        }
        else if (tmp == 0)
        {
            ret = "Parabola";
        }
        else if (tmp < 0)
        {
            ret = "Ellipse";
        }
        else
        {
            ret = "Hyperbola";
        }
    }
    return ret;
}

Conic* Conic::p_axis()
{
    string name = this->conic_name();
    Conic* l;

    if (name == "Parabola")
    {
        function_temp(this->a, this->h, this->b, this->g, this->f, this->c);
    }
    else if (name == "Ellipse")
    {
        Ellipse* e = new Ellipse(this->a, this->h, this->b, this->g, this->f, this->c);
        l = e->p_axis();
        return l;
    }
    else if(name == "Hyperbola")
    {
        Hyperbola* h = new Hyperbola(this->a, this->h, this->b, this->g, this->f, this->c);
        l = h->p_axis();
        return l;
    }
    
    cout << "Principal axis doesn't exist for this conic" << endl;
    return NULL;
}

double Conic::latus_rectum()
{
    string name = this->conic_name();
    double l;

    if (name == "Parabola")
    {
        Parabola* p = new Parabola(this->a, this->h, this->b, this->g, this->f, this->c);
        l = p->latus_rectum();
        return l;
    }
    else if (name == "Ellipse")
    {
        Ellipse* e = new Ellipse(this->a, this->h, this->b, this->g, this->f, this->c);
        l = e->latus_rectum();
        return l;
    }
    else if (name == "Hyperbola")
    {
        Hyperbola* h = new Hyperbola(this->a, this->h, this->b, this->g, this->f, this->c);
        l = h->latus_rectum();
        return l;
    }
    cout << "Latus rectum doesn't exist for this conic" << endl;
    return NULL;
}

Conic* Conic::directrix()
{
    string test = this->conic_name();
    Conic* l1;
    if(test == "Parabola"){
        Parabola* p = new Parabola(this->a, this->h, this->b, this->g, this->f, this->c);
        l1 = p->directrix();
    }
    else if(test == "Ellipse"){
        Ellipse* e = new Ellipse(this->a, this->h, this->b, this->g, this->f, this->c);
        l1 = e->directrix();
    }
    else if(test == "Hyperbola"){
        Hyperbola* h = new Hyperbola(this->a, this->h, this->b, this->g, this->f, this->c);
        l1 = h->directrix();
    }
    else{
        cout << "Directrix doesn't exist for this conic\n";
        return NULL;
    }
    return l1;
}

 Point* Conic::vertex()
 {
    string test = this->conic_name();
    Point* p1;
    if(test == "Parabola"){
        Parabola* p = new Parabola(this->a, this->h, this->b, this->g, this->f, this->c);
        p1 = p->vertex();
    }
    else if(test == "Ellipse"){
        Ellipse* e = new Ellipse(this->a, this->h, this->b, this->g, this->f, this->c);
        p1 = e->vertex();
    }
    else if(test == "Hyperbola"){
        Hyperbola* h = new Hyperbola(this->a, this->h, this->b, this->g, this->f, this->c);
        p1 = h->vertex();
    }
    else{
        cout << "Vertex doesn't exist for this conic\n";
        return NULL;
    }
    return p1;
}


Point* Conic::focii()
{
    string name = this->conic_name();
    Point* pt;
    if (name == "Circle")
    {
        Circle* c = new Circle(this->a, this->h, this->b, this->g, this->f, this->c);
        pt = c->focii();
        return pt;
    }
    if (name == "Parabola")
    {
        Parabola* p = new Parabola(this->a, this->h, this->b, this->g, this->f, this->c);
        pt = p->focii();
        return pt;
    }
    else if (name == "Ellipse")
    {
        Ellipse* e = new Ellipse(this->a, this->h, this->b, this->g, this->f, this->c);
        pt = e->focii();
        return pt;
    }
    else if (name == "Hyperbola")
    {
        Hyperbola* h = new Hyperbola(this->a, this->h, this->b, this->g, this->f, this->c);
        pt = h->focii();
        return pt;
    }
    
    cout << "Focii doesn't exist for this conic" << endl;
    return NULL;
}
