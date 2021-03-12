#include <iostream>
#include <math.h>

//这个程序用来计算一元二次方程的根

//计算方程根
std::pair<bool, std::pair<double, double>> quadratic (int a, int b, int c) {
    double inside = b*b - 4*a*c;
    std::pair<double, double> blank;
    if (inside < 0) return std::make_pair(false, blank);

    std::pair<double, double> answer = std::make_pair((-b+sqrt(inside))/2, (-b-sqrt(inside))/2);
    return std::make_pair(true, answer);
}

int main() {
    int a, b, c;
    std::cin >> a >> b >> c;  //输入三个数字

    //比较冗长的版本
    // std::pair<bool, std::pair<double, double>> result = quadratic(a, b, c);
    // if (result.first) {
    //     std::pair<double, double> solutions = result.second;
    //     std::cout << solutions.first << " " << solutions.second << std::endl;
    // } else {
    //     std::cout << "No solutions found!" << std::endl;
    // }

    //用了auto和structured binding的版本，c++17以上才支持structured binding
    //g++ -std=c++17 main.cpp -o main
    auto [judge, solutions] = quadratic(a, b, c);
    if (judge) {
        auto [x1, x2] = solutions;
        std::cout << x1 << " " << x2 << std::endl;
    } else {
        std::cout << "No solutions found!" << std::endl;
    }
}