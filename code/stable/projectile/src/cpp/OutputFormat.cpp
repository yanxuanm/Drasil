#include <iostream>
#include <fstream>
#include <string>

#include "OutputFormat.hpp"

using std::ofstream;
using std::string;

void write_output(string s, double d_offset) {
    ofstream outputfile;
    outputfile.open("output.txt", std::fstream::out);
    outputfile << "s = ";
    outputfile << s << std::endl;
    outputfile << "d_offset = ";
    outputfile << d_offset << std::endl;
    outputfile.close();
}