#include <iostream>
#include <cstdio>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <queue>
#include <set>
#include <map>
#include <cstring>
#include <iomanip>
#include <numeric>
#include <sstream>
#include <math.h>

struct Time;
struct Course;
void print_time(const Time& time);
void print_course(const Course& course);
void print_all_courses(const std::vector<Course>& courses);

struct Time {
    int hour, minute;
};

struct Course {
    std::string code;
    std::pair<Time, Time> time; //start and end times
    std::vector<std::string> instructors;
};

void shift(std::vector<Course>& courses) {
    for (auto& [code, time, instuctors] : courses) {
        time.first.hour++;
        time.second.hour++;
    }
}



int main() {
    Course now {"CS106L", { {16, 30}, {17, 50} }, {"Raghuraman", "Chi"} };
    Course before {"CS106B", { {14, 30}, {15, 20} }, {"Gregg", "Zelenski"} };
    Course future {"CS107", { {11, 30}, {12, 50} }, {"Troccoli"} };
    std::vector<Course> courses{now, before, future};

    std::cout << "\nTesting shift function.\n";
    std::cout << "Original list of courses:\n";
    print_all_courses(courses);
    shift(courses);
    std::cout << "\nAfter shifting all courses:\n";
    print_all_courses(courses);
}

void print_time(const Time& time) {
    std::cout << time.hour << ":" << time.minute;
}


void print_course(const Course& course) {
    std::cout << course.code << " ";
    print_time(course.time.first);
    std::cout << "-";
    print_time(course.time.second);
    std::cout << " ";
    for (const auto& in : course.instructors) {
        std::cout << in << " ";
    }
}


void print_all_courses(const std::vector<Course>& courses) {
    for (const auto& course : courses) {
        print_course(course);
        std::cout << "\n";
    }
}
